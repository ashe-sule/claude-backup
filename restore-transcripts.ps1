# Downloads ALL chat transcript backups from GitHub and restores them (oldest first, newer overwrite).
$ErrorActionPreference = 'Stop'
$repo = 'ashe-sule/claude-backup'
$bash = 'C:\Program Files\Git\bin\bash.exe'
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
    & $bash -lc 'cd ~/.claude && xz -dc "$CB_IN" | tar -xf -'
    if ($LASTEXITCODE -ne 0) { throw "Failed on $($a.name)" }
}
Remove-Item -Recurse -Force $dl
Write-Host "Done - restored $($assets.Count) backup(s)." -ForegroundColor Green
