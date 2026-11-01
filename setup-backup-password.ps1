# Run this ONCE yourself. Sets the password that encrypts your chat transcript backups.
# The password is stored locked to your Windows account (DPAPI) so the daily task can use it.
# SAVE THIS PASSWORD IN YOUR PASSWORD MANAGER - without it, transcript backups cannot be opened.
$keyFile = Join-Path $HOME '.claude\.transcript-key'
$p1 = Read-Host 'Choose a backup password (12+ chars)' -AsSecureString
$p2 = Read-Host 'Type it again' -AsSecureString
$a = [Runtime.InteropServices.Marshal]::PtrToStringBSTR([Runtime.InteropServices.Marshal]::SecureStringToBSTR($p1))
$b = [Runtime.InteropServices.Marshal]::PtrToStringBSTR([Runtime.InteropServices.Marshal]::SecureStringToBSTR($p2))
if ($a -ne $b) { Write-Host 'Passwords do not match. Run again.' -ForegroundColor Red; exit 1 }
if ($a.Length -lt 12) { Write-Host 'Too short - use 12+ characters.' -ForegroundColor Red; exit 1 }
$p1 | ConvertFrom-SecureString | Set-Content $keyFile
Write-Host 'Saved. Now store this password in your password manager!' -ForegroundColor Green
