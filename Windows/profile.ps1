$POWERSHELL_PROFILE = "${env:USERPROFILE}\Documents\WindowsPowerShell\profile.ps1"

#
# Create an empty file
#
function Touch-File {
	$file = $args[0]
	if($file -eq $null) {
		throw "No Filename Supplied"
	}
	if(Test-Path $file) {
		throw "File already exists"
	} else {
		"" > $file
	}
}
Set-Alias -Name touch -Value Touch-File


#
# Open notepad++ (optionally pass file to open)
#
function Open-Notepad-Plus-Plus {
	$file = $args[0]
	$program = "C:\Program Files (x86)\Notepad++\notepad++.exe"

	if($file -eq $null) {
		& $program
	} else {
		if(-Not (Test-Path $file)) {
			Touch-File $file
		}
		& $program $file
	}
}
Set-Alias -Name edit -Value Open-Notepad-Plus-Plus


#
# Sign a PowerShell script with signing certificate
#
function Sign-PowerShell-Script {
	$cert = $(Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert)
	Set-AuthenticodeSignature ${args}[0] -Certificate ${cert} > $null
}
Set-Alias -Name sign -Value Sign-PowerShell-Script


#
# Sign and then run a PowerShell script
#
function Sign-And-Run-PowerShell-Script {
	sign ${args}[0]
	Invoke-Expression -Command ${args}[0]
}
Set-Alias -Name run -Value Sign-And-Run-PowerShell-Script


#
# Customize command prompt to be on two lines
#
function prompt {
	If (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
		# If logged in as an Administrator
		$u = "ADMIN "
	}
	$p = $pwd."Path"

	Write-Host ""
	Write-Host "PS " -nonewline
	Write-Host "${u}" -nonewline -ForegroundColor Red
	Write-Host "${p}`n>" -nonewline

	return " "
}


# Make things neat
Clear-Host
