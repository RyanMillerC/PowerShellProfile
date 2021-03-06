$windir = "${env:USERPROFILE}\Documents\WindowsPowerShell"
$file = "${windir}\profile.ps1"

Write-Host "" # Blank line before script output

if(-Not (Test-Path $windir)) {
	Write-Host "$windir does not exist, creating..."
	(mkdir $windir) | Out-Null
	Write-Host "Done!`n"
}

if(-Not (Test-Path $file)) {
	Write-Host "Copying profile.ps1 to $file..."
	cp profile.ps1 $file
} else {
	Write-Host "$file already exists! Updating..."
	cp -Force profile.ps1 $file
	Write-Host "Done!`n"
}
