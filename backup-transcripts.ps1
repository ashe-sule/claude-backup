# Incremental, encrypted backup of Claude chat transcripts -> GitHub Release (private repo)
# Only uploads chats that are new/changed since the last successful upload.
$ErrorActionPreference = 'Stop'
$root    = Join-Path $HOME '.claude'
$log     = Join-Path $root 'backup.log'
$keyFile = Join-Path $root '.transcript-key'
$stamp   = Join-Path $root '.transcript-stamp'
$repo    = 'ashe-sule/claude-backup'
$bash    = 'C:\Program Files\Git\bin\bash.exe'
function Log($m) { "$(Get-Date -f 'yyyy-MM-dd HH:mm:ss')  [transcripts] $m" | Add-Content $log }

if (-not (Test-Path $keyFile)) { Log 'SKIP: no password set - run setup-backup-password.ps1'; return }

# Password (DPAPI) -> env var for openssl only (never written to disk in plain text)
$sec = Get-Content $keyFile | ConvertTo-SecureString
$env:CLAUDE_BACKUP_PASS = [Runtime.InteropServices.Marshal]::PtrToStringBSTR([Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec))

$name = "transcripts-$(Get-Date -f 'yyyyMMdd-HHmmss').tar.xz.enc"
$out  = Join-Path $env:TEMP $name
$env:CB_OUT = $out.Replace([string][char]92,'/')
try {
    # Build archive of new/changed files only (bash: find + tar + xz + openssl AES-256)
    & $bash -lc @'
set -o pipefail
cd ~/.claude
touch .transcript-stamp.new
if [ -f .transcript-stamp ]; then NEWER="-newer .transcript-stamp"; else NEWER=""; fi
{ find projects -path '*/memory' -prune -o -type f $NEWER -print
  [ -z "$NEWER" ] || [ history.jsonl -nt .transcript-stamp ] && echo history.jsonl
} > /tmp/cb-list.txt
COUNT=$(wc -l < /tmp/cb-list.txt)
if [ "$COUNT" -eq 0 ]; then echo NOCHANGE; exit 0; fi
tar -cf - --ignore-failed-read -T /tmp/cb-list.txt 2>/dev/null | xz -T2 -9e \
 | openssl enc -aes-256-cbc -pbkdf2 -iter 200000 -salt -pass env:CLAUDE_BACKUP_PASS -out "$CB_OUT"
echo "FILES=$COUNT"
'@ | Tee-Object -Variable res | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "archive step failed (exit $LASTEXITCODE)" }
    $res = $res -join ' '
    if ($res -match 'NOCHANGE') { Log 'OK: no new chats'; return }
    $files = [regex]::Match($res,'FILES=([0-9]+)').Groups[1].Value

    # GitHub token from your saved git login (Git Credential Manager)
    $token = ("protocol=https`nhost=github.com`n`n" | git credential fill | Select-String '^password=').ToString().Substring(9)
    $h = @{ Authorization = "Bearer $token"; Accept = 'application/vnd.github+json' }

    # One release per year (keeps each under GitHub's asset limit)
    $tag = "transcripts-$(Get-Date -f yyyy)"
    try { $rel = Invoke-RestMethod "https://api.github.com/repos/$repo/releases/tags/$tag" -Headers $h }
    catch {
        $body = @{ tag_name = $tag; name = "Chat transcripts $(Get-Date -f yyyy) (encrypted)"; body = 'Encrypted incremental chat backups. See RESTORE.md.' } | ConvertTo-Json
        $rel = Invoke-RestMethod "https://api.github.com/repos/$repo/releases" -Method Post -Headers $h -Body $body -ContentType 'application/json'
    }
    $mb = [math]::Round((Get-Item $out).Length / 1MB, 1)
    Invoke-RestMethod "https://uploads.github.com/repos/$repo/releases/$($rel.id)/assets?name=$name" `
        -Method Post -Headers $h -InFile $out -ContentType 'application/octet-stream' -TimeoutSec 3600 | Out-Null

    Move-Item -Force (Join-Path $root '.transcript-stamp.new') $stamp
    Log "OK: uploaded $name ($files files, $mb MB)"
}
catch { Log "FAIL: $($_.Exception.Message)" }
finally {
    Remove-Item $out -ErrorAction SilentlyContinue
    Remove-Item Env:CLAUDE_BACKUP_PASS -ErrorAction SilentlyContinue
}
