# Incremental backup of Claude chat transcripts -> GitHub Release (private repo)
# Only new/changed chats since last upload. Secrets are blanked out (redact.sed) in the
# backup copy, then max-compressed (xz -9e). No password needed to restore.
$ErrorActionPreference = 'Stop'
$root  = Join-Path $HOME '.claude'
$log   = Join-Path $root 'backup.log'
$stamp = Join-Path $root '.transcript-stamp'
$repo  = 'ashe-sule/claude-backup'
$bash  = 'C:\Program Files\Git\bin\bash.exe'
function Log($m) { "$(Get-Date -f 'yyyy-MM-dd HH:mm:ss')  [transcripts] $m" | Add-Content $log }

$name = "transcripts-$(Get-Date -f 'yyyyMMdd-HHmmss').tar.xz"
$out  = Join-Path $env:TEMP $name
$env:CB_OUT = $out.Replace([string][char]92,'/')
try {
    & $bash -lc @'
set -o pipefail
cd ~/.claude
touch .transcript-stamp.new
if [ -f .transcript-stamp ]; then NEWER="-newer .transcript-stamp"; else NEWER=""; fi
LIST=$(mktemp); STAGE=$(mktemp -d)
{ find projects -path '*/memory' -prune -o -type f $NEWER -print
  [ -z "$NEWER" ] || [ history.jsonl -nt .transcript-stamp ] && echo history.jsonl
} > "$LIST"
COUNT=$(wc -l < "$LIST")
if [ "$COUNT" -eq 0 ]; then echo NOCHANGE; rm -rf "$LIST" "$STAGE"; exit 0; fi
# copy to staging, redact secrets there (originals untouched)
tar -cf - --ignore-failed-read -T "$LIST" 2>/dev/null | tar -xf - -C "$STAGE"
find "$STAGE" -type f \( -name '*.jsonl' -o -name '*.json' -o -name '*.txt' -o -name '*.md' -o -name '*.log' \) -print0 \
  | xargs -0 -r sed -E -i -f redact.sed
tar -cf - -C "$STAGE" . | xz -T2 -9e > "$CB_OUT"
RC=$?; rm -rf "$LIST" "$STAGE"
echo "FILES=$COUNT"; exit $RC
'@ | Tee-Object -Variable res | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "archive step failed (exit $LASTEXITCODE)" }
    $res = $res -join ' '
    if ($res -match 'NOCHANGE') { Log 'OK: no new chats'; return }
    $files = [regex]::Match($res,'FILES=([0-9]+)').Groups[1].Value

    $token = ("protocol=https`nhost=github.com`n`n" | git credential fill | Select-String '^password=').ToString().Substring(9)
    $h = @{ Authorization = "Bearer $token"; Accept = 'application/vnd.github+json' }
    $tag = "transcripts-$(Get-Date -f yyyy)"
    try { $rel = Invoke-RestMethod "https://api.github.com/repos/$repo/releases/tags/$tag" -Headers $h }
    catch {
        $body = @{ tag_name = $tag; name = "Chat transcripts $(Get-Date -f yyyy)"; body = 'Incremental chat backups (secrets redacted, xz -9e). See RESTORE.md.' } | ConvertTo-Json
        $rel = Invoke-RestMethod "https://api.github.com/repos/$repo/releases" -Method Post -Headers $h -Body $body -ContentType 'application/json'
    }
    $mb = [math]::Round((Get-Item $out).Length / 1MB, 1)
    Invoke-RestMethod "https://uploads.github.com/repos/$repo/releases/$($rel.id)/assets?name=$name" `
        -Method Post -Headers $h -InFile $out -ContentType 'application/x-xz' -TimeoutSec 3600 | Out-Null
    Move-Item -Force (Join-Path $root '.transcript-stamp.new') $stamp
    Log "OK: uploaded $name ($files files, $mb MB)"
}
catch { Log "FAIL: $($_.Exception.Message)" }
finally { Remove-Item $out -ErrorAction SilentlyContinue }
