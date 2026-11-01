# Daily Claude Code backup -> github.com/ashe-sule/claude-backup (private)
$ErrorActionPreference = 'Continue'
$repo = Join-Path $HOME '.claude'
$log  = Join-Path $repo 'backup.log'
Set-Location $repo
function Log($m) { "$(Get-Date -f 'yyyy-MM-dd HH:mm:ss')  $m" | Add-Content $log }

git add -A 2>&1 | Out-Null
if (git ls-files | Select-String -Pattern 'credentials' -Quiet) {
    Log 'ABORT: credentials file is tracked - not pushing'; exit 1
}
if (git status --porcelain) {
    git commit -q -m "Auto backup $(Get-Date -f 'yyyy-MM-dd HH:mm')" 2>&1 | Out-Null
    $out = git push -q origin main 2>&1
    if ($LASTEXITCODE -eq 0) { Log 'OK: changes pushed' } else { Log "FAIL: push error - $out" }
} else {
    Log 'OK: no changes'
}
# keep log small
if ((Get-Item $log).Length -gt 100KB) { Get-Content $log -Tail 200 | Set-Content $log }
