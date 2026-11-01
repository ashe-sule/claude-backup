# Downloads ALL encrypted transcript backups from GitHub and restores them (oldest first, newer overwrite).
$ErrorActionPreference = 'Stop'
$repo = 'ashe-sule/claude-backup'; $root = Join-Path $HOME '.claude'
$bash = 'C:\Program Files\Git\bin\bash.exe'
$sec = Read-Host 'Backup password' -AsSecureString
$env:CLAUDE_BACKUP_PASS = [Runtime.InteropServices.Marshal]::PtrToStringBSTR([Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec))
$token = ("protocol=https`nhost=github.com`n`n" | git credential fill | Select-String '^password=').ToString().Substring(9)
$h = @{ Authorization = "Bearer $token" }
$dl = Join-Path $env:TEMP 'claude-restore'; New-Item -ItemType Directory -Force $dl | Out-Null
$rels = Invoke-RestMethod "https://api.github.com/repos/$repo/releases?per_page=100" -Headers $h | Where-Object tag_name -like 'transcripts-*'
$assets = $rels | ForEach-Object { $_.assets } | Sort-Object name
foreach ($a in $assets) {
    Write-Host "Restoring $($a.name)..."
    $f = Join-Path $dl $a.name
    Invoke-WebRequest $a.url -Headers ($h + @{ Accept = 'application/octet-stream' }) -OutFile $f
    $env:CB_IN = $f.Replace([string][char]92,'/')
    & $bash -lc 'cd ~/.claude && openssl enc -d -aes-256-cbc -pbkdf2 -iter 200000 -pass env:CLAUDE_BACKUP_PASS -in "$CB_IN" | xz -d | tar -xf -'
    if ($LASTEXITCODE -ne 0) { throw "Failed on $($a.name) - wrong password?" }
}
Remove-Item -Recurse -Force $dl; Remove-Item Env:CLAUDE_BACKUP_PASS
Write-Host "Done - restored $($assets.Count) backup(s)." -ForegroundColor Green
