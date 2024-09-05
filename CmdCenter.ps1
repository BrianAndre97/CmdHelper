write-Host "
:) Consider buying me a coffee! 
https://buymeacoffee.com/brianandrec
"


Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'COMMAND CENTER'
$form.Size = New-Object System.Drawing.Size(300,210)
$form.StartPosition = 'CenterScreen'

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(100,5)
$label.Size = New-Object System.Drawing.Size(100,15)
$label.Text = 'Command is for:'
$form.Controls.Add($label)

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,140)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'Copy'
#$okButton.DialogResult = $okButton_Action
$okButton_Action = {

Set-Clipboard -value "NULL"
    if ($listBox.SelectedItem -contains "Get FSMO Roles") {
        Set-Clipboard -value "netdom query fsmo"
		$cmdps.Text = "CMD"

	} 
    elseif ($listBox.SelectedItem -contains "Get RAM Info") {
        Set-Clipboard -value "wmic MEMORYCHIP get BankLabel, DeviceLocator, MemoryType, TypeDetail, Capacity, Speed"
		$cmdps.Text = "CMD"
    }
    elseif ($listBox.SelectedItem -contains "Get CPU Info") {
        Set-Clipboard -value "wmic cpu get caption, deviceid, name, numberofcores, maxclockspeed, status"
		$cmdps.Text = "CMD"
    }
	elseif ($listBox.SelectedItem -contains "Add to Domain") {
        Set-Clipboard -value "Add-Computer -DomainName"
		$cmdps.Text = "PS"
    }
    elseif ($listBox.SelectedItem -contains "AD Server Diagnosis") {
        Set-Clipboard -value "dcdiag"
		$cmdps.Text = "CMD"
    }
	elseif ($listBox.SelectedItem -contains "AD Get List of Users in a Group") {
        Set-Clipboard -value "Get-ADGroupMember -Identity administrators | Format-Table"
		$cmdps.Text = "PS"
	}
	elseif ($listBox.SelectedItem -contains "FlushDNS") {
        Set-Clipboard -value "ipconfig /flushdns"
		$cmdps.Text = "CMD"
    }
	elseif ($listBox.SelectedItem -contains "IP Config info") {
        Set-Clipboard -value "ipconfig /all"
		$cmdps.Text = "CMD"
	}
	elseif ($listBox.SelectedItem -contains "View if Recyle bin is enabled in AD") {
        Set-Clipboard -value 'Get-ADOptionalFeature “Recycle Bin Feature” | select-object name,IsDisableable | Format-Table'
		$cmdps.Text = "PS"	
	}
	elseif ($listBox.SelectedItem -contains "Get List of Printers") {
        Set-Clipboard -value "wmic printer list brief"
		$cmdps.Text = "CMD"	
	}
	elseif ($listBox.SelectedItem -contains "View PW Policy") {
        Set-Clipboard -value "net accounts"
		$cmdps.Text = "CMD"	
	}
	elseif ($listBox.SelectedItem -contains "Get SN") {
        Set-Clipboard -value "Wmic bios get serialnumber, manufacturer"
		$cmdps.Text = "CMD"	
	}
	elseif ($listBox.SelectedItem -contains "List of installed Programs") {
        Set-Clipboard -value "wmic product get name, Vendor, Version"
		$cmdps.Text = "CMD"
	}
	elseif ($listBox.SelectedItem -contains "Get list of Drives") {
        Set-Clipboard -value "Get-PSDrive *"
		$cmdps.Text = "PS"
	}
	elseif ($listBox.SelectedItem -contains "Get Stopped Services") {
        Set-Clipboard -value 'Get-Service | Where-Object {$_.Status -eq "Stopped"}'
		$cmdps.Text = "PS"
	}
	elseif ($listBox.SelectedItem -contains "Get WAN IP") {
        Set-Clipboard -value "nslookup myip.opendns.com. resolver1.opendns.com"
		$cmdps.Text = "CMD"
    }
	elseif ($listBox.SelectedItem -contains "Uninstall a Program") {
        Set-Clipboard -value "set /p id=Enter program name: && wmic product where name=%id% call uninstall"
		$cmdps.Text = "CMD"
    }
	elseif ($listBox.SelectedItem -contains "Accounts Running Services") {
        Set-Clipboard -value "wmic service get Caption,StartName"
		$cmdps.Text = "CMD"
    }
	elseif ($listBox.SelectedItem -contains "Get GPU Info") {
        Set-Clipboard -value "wmic path win32_VideoController get name, videoprocessor, CurrentRefreshRate, SystemName, AdapterRAM"
		$cmdps.Text = "CMD"
    }
	elseif ($listBox.SelectedItem -contains "PS Remote Session") {
        Set-Clipboard -value "Enter-PSSession -computername"
		$cmdps.Text = "PS"
    }
    elseif ($listBox.SelectedItem -contains "Get List of WiFi PW") {
        Set-Clipboard -value '(netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | %{(netsh wlan show profile name="$name" key=clear)}  | Select-String "Key Content\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | %{[PSCustomObject]@{ PROFILE_NAME=$name;PASSWORD=$pass }} | Format-Table -AutoSize'
		$cmdps.Text = "PS"
    }
    elseif ($listBox.SelectedItem -contains "Get Local Firewall Config") {
        Set-Clipboard -value "netsh firewall show config"
		$cmdps.Text = "CMD"
    }
    elseif ($listBox.SelectedItem -contains "Get DNS Records") {
        Set-Clipboard -value "get-dnsclientcache | Format-Table"
		$cmdps.Text = "PS"
    }
    elseif ($listBox.SelectedItem -contains "View Site Links") {
        Set-Clipboard -value '$site = Read-Host "Target Site:" ; (Invoke-WebRequest -uri $site).Links | format-table -Verbose'
		$cmdps.Text = "PS"
    }
    elseif ($listBox.SelectedItem -contains "View Route Table") {
        Set-Clipboard -value 'route PRINT'
		$cmdps.Text = "CMD"
    }
    elseif ($listBox.SelectedItem -contains "View Live Network Connections") {
        Set-Clipboard -value 'netstat -a'
		$cmdps.Text = "CMD"
    }
    elseif ($listBox.SelectedItem -contains "AD LastLoginTimeStamp Enabled Accts") {
        Set-Clipboard -value 'Get-ADUser -Filter {enabled -eq $true} -Properties distinguishedName, LastLogonTimeStamp, Description | Select-Object distinguishedName,Name,Description,@{Name="Stamp"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp).ToString()}}| export-csv -Verbose $env:HOMEPATH\lastlogon.csv ; start $env:HOMEPATH\'
		$cmdps.Text = "PS"
    }
    elseif ($listBox.SelectedItem -contains "AD Non-Expiring PW Accts") {
        Set-Clipboard -value 'Get-ADUser -filter {enabled -eq $true} -properties passwordlastset, passwordneverexpires | export-csv -verbose $env:HOMEPATH\nonexp.csv ; start $env:HOMEPATH\'
    }
    elseif ($listBox.SelectedItem -contains "Get NIC LinkSpeeds") {
        Set-Clipboard -value 'Get-NetAdapter | select interfaceDescription, name, status, linkSpeed'
        $cmdps.Text = "PS"
    }
}

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,140)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$cmdps = New-Object System.Windows.Forms.TextBox
$cmdps.Location = New-Object System.Drawing.Point(200,3)
$cmdps.Size = New-Object System.Drawing.Size(50,10)
$cmdps.Text = ""
$form.Controls.Add($cmdps)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,35)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Select command:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,60)
$listBox.Size = New-Object System.Drawing.Size(260,20)
$listBox.Height = 80

[void] $listBox.Items.Add('Get RAM Info')
[void] $listBox.Items.Add('Get CPU Info')
[void] $listBox.Items.Add('Add to Domain')
[void] $listBox.Items.Add('Get NIC LinkSpeeds')
[void] $listBox.Items.Add('Get FSMO Roles')
[void] $listBox.Items.Add('AD Server Diagnosis')
[void] $listBox.Items.Add('AD LastLoginTimeStamp Enabled Accts')
[void] $listBox.Items.Add('AD Non-Expiring PW Accts')
[void] $listBox.Items.Add('AD Get List of Users in a Group')
[void] $listBox.Items.Add('FlushDNS')
[void] $listBox.Items.Add('IP Config info')
[void] $listBox.Items.Add('View if Recyle bin is enabled in AD')
[void] $listBox.Items.Add('Get List of Printers')
[void] $listBox.Items.Add('View PW Policy')
[void] $listBox.Items.Add('Get SN')
[void] $listBox.Items.Add('List of installed Programs')
[void] $listBox.Items.Add('Get list of Drives')
[void] $listBox.Items.Add('Get WAN IP')
[void] $listBox.Items.Add('Uninstall a Program')
[void] $listBox.Items.Add('Accounts Running Services')
[void] $listBox.Items.Add('Get GPU Info')
[void] $listBox.Items.Add('PS Remote Session')
[void] $listBox.Items.Add('Get List of WiFi PW')
[void] $listBox.Items.Add('Get Local Firewall Config')
[void] $listBox.Items.Add('Get DNS Records')
[void] $listBox.Items.Add('View Site Links')
[void] $listBox.Items.Add('View Route Table')
[void] $listBox.Items.Add('View Live Network Connections')
[void] $listBox.Items.Add('Get General Site info')
[void] $listBox.Items.Add('WhoIS IPAddress')


$okButton.Add_Click($okButton_Action)
$form.Controls.Add($okButton)

$form.Controls.Add($listBox)

$form.Topmost = $true

#Run Button
$runbutton = New-Object System.Windows.Forms.Button
$runbutton.Location = New-Object System.Drawing.Point(5,140)
$runbutton.AutoSize = $true
$runbutton.Width = 70
$runbutton.Height = 10
$runbutton.Text = 'Run'
#$okButton.DialogResult = $okButton_Action
$runbutton_Action = {
    if ($listBox.SelectedItem -contains 'FlushDNS') { 
        $flushdns = cmd.exe /c "ipconfig /flushdns"
        Write-Host $flushdns
        
    }
        if ($listBox.SelectedItem -contains "Get NIC LinkSpeeds") {
        $LInkspeed = powershell.exe /C "Get-NetAdapter | select interfaceDescription, name, status, linkSpeed"
		Write-Host $LInkspeed
    }
    elseif ($listBox.SelectedItem -contains "Get RAM Info") {
        $FSMO = cmd.exe /c "wmic MEMORYCHIP get BankLabel, DeviceLocator, MemoryType, TypeDetail, Capacity, Speed"
		Write-Host $FSMO
    } 
    elseif ($listBox.SelectedItem -contains "Get CPU Info") {
        $FSMO = cmd.exe /c "wmic cpu get caption, deviceid, name, numberofcores, maxclockspeed, status"
		Write-Host $FSMO
    } 
    elseif ($listBox.SelectedItem -contains "Get FSMO Roles") {
        $FSMO = cmd.exe /c "netdom query fsmo"
		Write-Host $FSMO
    }
	elseif ($listBox.SelectedItem -contains "AD Server Diagnosis") {
        $ServerDiag = cmd.exe /c "dcdiag"
        Write-Host $ServerDiag
    }
	elseif ($listBox.SelectedItem -contains "Get List of Users in a Group") {
        $adusergroup = powershell.exe /c "Get-ADGroupMember -Identity administrators | Format-Table" | format-list | out-string
		Write-Host $adusergroup
	}
	elseif ($listBox.SelectedItem -contains "IP Config info") {
        $ipconfig = powershell.exe /c "ipconfig /all" | Format-Table | out-string
		Write-Host $ipconfig
	}
	elseif ($listBox.SelectedItem -contains "View if Recyle bin is enabled in AD") {
        $recyclebin =  powershell.exe /c "Get-ADOptionalFeature “Recycle Bin Feature” | select-object name,IsDisableable | Format-Table Format-Table | out-string"
		write-host $recyclebin 
	}
	elseif ($listBox.SelectedItem -contains "Get Non-Expiring PW in AD") {
        $expiringpw = powershell.exe /c "Get-ADUser -filter * -properties passwordlastset, passwordneverexpires | ft Name, passwordlastset, Passwordneverexpires | Format-Table | out-string" | format-table | out-string
		write-host $expiringpw | Format-Table | out-string
	}
	elseif ($listBox.SelectedItem -contains "Get List of Printers") {
        $printerlist = cmd.exe /c "wmic printer list brief" | format-table | out-string
		write-host $printerlist
	}
	elseif ($listBox.SelectedItem -contains "View PW Policy") {
        $pwpolicy = cmd.exe /c "net accounts" | format-table | out-string
		write-host $pwpolicy
	}
	elseif ($listBox.SelectedItem -contains "Get SN") {
        $getsn = cmd.exe /c "Wmic bios get serialnumber, manufacturer" | format-table | out-string
		write-host $getsn
	}
	elseif ($listBox.SelectedItem -contains "List of installed Programs") {
        $installedapps = cmd.exe /c "wmic product get name, Vendor, Version" | format-table | out-string
		write-host $installedapps
	}
	elseif ($listBox.SelectedItem -contains "Get list of Drives") {
        $listofdrives = powershell.exe /c "Get-PSDrive *" | format-table | out-string
		write-host $listofdrives
	}
	elseif ($listBox.SelectedItem -contains "Get Stopped Services") {
        $stoppedservices = Get-Service | Where-Object {$_.Status -eq "Stopped"} | format-table | out-string
		write-host $stoppedservices
	}
	elseif ($listBox.SelectedItem -contains "Get WAN IP") {
        $wanip = cmd.exe /c "nslookup myip.opendns.com. resolver1.opendns.com" | format-table | out-string
		write-host $wanip
    }
	elseif ($listBox.SelectedItem -contains "Uninstall a Program") {
        Write-host "Unable to run, please use the Copy function"
		
    }
	elseif ($listBox.SelectedItem -contains "Accounts Running Services") {
        $acctsvs = cmd.exe /c "wmic service get Caption,StartName" | Format-Table | out-string
		write-host $acctsvs
    }
	elseif ($listBox.SelectedItem -contains "Get GPU Info") {
        $gpuinfo = cmd.exe /c "wmic path win32_VideoController get name, videoprocessor, CurrentRefreshRate, SystemName, AdapterRAM" | Format-Table | out-string
		write-host $gpuinfo
    }
	elseif ($listBox.SelectedItem -contains "PS Remote Session") {
        Enter-PSSession -computername (Read-host "Enter PC Name")
		
    }
    elseif ($listBox.SelectedItem -contains "Get List of WiFi PW") {
        $wifipw = (netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | %{(netsh wlan show profile name="$name" key=clear)}  | Select-String "Key Content\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | %{[PSCustomObject]@{ PROFILE_NAME=$name;PASSWORD=$pass }} | Format-Table -AutoSize | out-string
		write-host $wifipw
    }
    elseif ($listBox.SelectedItem -contains "Get Local Firewall Config") {
        $fwlist = cmd.exe /c "netsh firewall show config" | Format-Table | out-string
		write-host $fwlist
    }
    elseif ($listBox.SelectedItem -contains "Get DNS Records") {
        $dnsrecords = get-dnsclientcache | Format-Table | out-string
		write-host $dnsrecords
    }
    elseif ($listBox.SelectedItem -contains "View Site Links") {
        $site = Read-Host "Target Site:" ; (Invoke-WebRequest -uri $site).Links | format-table -Verbose | out-string
		
    }
    elseif ($listBox.SelectedItem -contains "View Route Table") {
        $route = cmd.exe /c "route PRINT" | format-list | out-string
		Write-host $route
    }
    elseif ($listBox.SelectedItem -contains "View Live Network Connections") {
        $netstat = cmd.exe /c 'netstat -a' | format-list | out-string
		write-host "Takes some time, please wait"
        write-host $netstat
    }


}
$form.Controls.Add($runbutton)
$runbutton.Add_Click($runbutton_Action)
$form.Controls.Add($runbutton)

$result = $form.ShowDialog()




# SIG # Begin signature block
# MIIMXAYJKoZIhvcNAQcCoIIMTTCCDEkCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU2Js43P0/HkIBbEets2AXz64Q
# 6Nygggm0MIIDpDCCAoygAwIBAgIQfc+7VtXaeohAz4py/eVfbTANBgkqhkiG9w0B
# AQsFADBaMRUwEwYKCZImiZPyLGQBGRYFbG9jYWwxHTAbBgoJkiaJk/IsZAEZFg1U
# aGVOZXR3b3JrUHJvMSIwIAYDVQQDExlUaGVOZXR3b3JrUHJvLVROUERDLTAyLUNB
# MB4XDTIwMDEyMjIyNDQ1N1oXDTI1MDEyMjIyNTQ1NlowWjEVMBMGCgmSJomT8ixk
# ARkWBWxvY2FsMR0wGwYKCZImiZPyLGQBGRYNVGhlTmV0d29ya1BybzEiMCAGA1UE
# AxMZVGhlTmV0d29ya1Byby1UTlBEQy0wMi1DQTCCASIwDQYJKoZIhvcNAQEBBQAD
# ggEPADCCAQoCggEBAKUwFvofSCuoLmW7ANqD+b2sPzGJGR5NUI6yXK8xvZd37Ifl
# JV2Nxvi2k/qwb4xGR5ONC7NRpq1+tDfTawNZk9Jv7KnMt8ycI95hSlEWkRqacaXg
# xd9CRlztJziSxTyP+pRYaJLzjg8NGv/zmebpRugKs7MruefB0amuMFFVgAlCPMpv
# FBCbYo/OKHbOTMAprmWix4XnIOETVuk+UogCP3N7s1gP4kqqojIyrw9bdFRzVBya
# bmM//d5unF4/pjwICUY2Y4JT1NGSd7kIRkZ9lcT9XW1m11boD+T2/ZhUrOzDwXCu
# Va4m1Y3pPtGelyN2DT/odLngodigNpgZ7yPK0u0CAwEAAaNmMGQwEwYJKwYBBAGC
# NxQCBAYeBABDAEEwCwYDVR0PBAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0O
# BBYEFB8M8aeyGtcdsobvbgFgQ6xabFOGMBAGCSsGAQQBgjcVAQQDAgEAMA0GCSqG
# SIb3DQEBCwUAA4IBAQARK94DSCaa15ssIApA91FSSJcCy9Q0zH5a5rHd/Xe/l9LH
# tgy703Z2puSQWptkPoiYxcWuDqtxFfN+lx+y7dn7Nm9+PE3SwaKEpSfwBUp86ZoY
# h+DKS3txrz7WmTqMwf0M09tdGcKNb+oPfQNtDyRRk+3jJvyV5QO4nLa8+TRUMvX9
# khtjzlISLfmeE09ngnTpC1w0tSKWPUILqHp9idQXoyp94ps4wm/ifqgP+6oqYuS+
# Btq5+fp9uVaLiiy6zI4K9eYDeuTE28A5q1g7yrf3H8wuBog9x6FVzlMXkpqJbNZm
# 4Hi9P7y0Szr1sof0cUXjeyp6fODxFcUyV7kJWbdfMIIGCDCCBPCgAwIBAgITIgAA
# AAM4TldHF8EO2gAAAAAAAzANBgkqhkiG9w0BAQsFADBaMRUwEwYKCZImiZPyLGQB
# GRYFbG9jYWwxHTAbBgoJkiaJk/IsZAEZFg1UaGVOZXR3b3JrUHJvMSIwIAYDVQQD
# ExlUaGVOZXR3b3JrUHJvLVROUERDLTAyLUNBMB4XDTIwMDUyNzIxNTIzOVoXDTIy
# MDUyNzIyMDIzOVowbTEVMBMGCgmSJomT8ixkARkWBWxvY2FsMR0wGwYKCZImiZPy
# LGQBGRYNVGhlTmV0d29ya1BybzEMMAoGA1UECxMDVE5QMRAwDgYDVQQLEwdTdXBw
# b3J0MRUwEwYDVQQDEwxBbmRyZXcgRG9yaWEwggEiMA0GCSqGSIb3DQEBAQUAA4IB
# DwAwggEKAoIBAQDQd0NvhL/syVKShH784XqxjQKICUDAw/vRbGDRQ8vpLxpyUvN0
# zb+WgwDfE0rZBfSPWwpLM+kBT+I930Je6q9G1CCGySsYCoALmXlMQDaG642g5epd
# bUip2l1Y10hF32lc6LlSR4Gtf2NKuCOiEyJkzsUfODAxgppFr79K7amlFu4hutwh
# GawZKxzDgjljzQ9MRYQdyQr6Eyz0v+a5BQ9qypCOeSHQHjA0YrePea/n33WoQAK+
# yXTyknPc3ZtIt08y6IyYdYIZDheX69c5ECerkdD9V5hvQuVT3ARLVK7cljHNm5sy
# lQ9I+ZEzBM9VWqqs/IR0eM/qLauE9wvMRUmNAgMBAAGjggKyMIICrjA9BgkrBgEE
# AYI3FQcEMDAuBiYrBgEEAYI3FQiBtpVzgerBa4OFgQqF+PlyyI4VgV+D1bAag9Da
# UgIBZAIBAzATBgNVHSUEDDAKBggrBgEFBQcDAzALBgNVHQ8EBAMCB4AwGwYJKwYB
# BAGCNxUKBA4wDDAKBggrBgEFBQcDAzAdBgNVHQ4EFgQUcOdUjckbaPrSdSxWgORd
# HIBFrlIwHwYDVR0jBBgwFoAUHwzxp7Ia1x2yhu9uAWBDrFpsU4YwgeIGA1UdHwSB
# 2jCB1zCB1KCB0aCBzoaBy2xkYXA6Ly8vQ049VGhlTmV0d29ya1Byby1UTlBEQy0w
# Mi1DQSxDTj1UTlAtT0MtREMyLENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2
# aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPVRoZU5ldHdvcmtQ
# cm8sREM9bG9jYWw/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVj
# dENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50MIHTBggrBgEFBQcBAQSBxjCBwzCB
# wAYIKwYBBQUHMAKGgbNsZGFwOi8vL0NOPVRoZU5ldHdvcmtQcm8tVE5QREMtMDIt
# Q0EsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2Vz
# LENOPUNvbmZpZ3VyYXRpb24sREM9VGhlTmV0d29ya1BybyxEQz1sb2NhbD9jQUNl
# cnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0
# eTAzBgNVHREELDAqoCgGCisGAQQBgjcUAgOgGgwYYWRvcmlhQHRoZW5ldHdvcmtw
# cm8ubmV0MA0GCSqGSIb3DQEBCwUAA4IBAQCezYF8j/C4CkTuB+GlhYAV2EATuki/
# mXrujOsLabXbX84aosNlOD7w/kXQsT25fAGkV1B4RB6bK5/smVpN71VTlRelnVkF
# 1uZ7EoS/UigIV7pUCYiZ9ePCm1Qh+iO8sBXIhAzzd7Xwt2usLcOkcxkzu/4M7i9g
# J8kY+gx4mPz0Rkg5IVfYrg5cd6Wj6dBHvPGs6QhQJx3mvxE6OAgxeiWnwnABp8J3
# hexeAda1ucQOK0w4hVPJ8qH8OURAQPSWRLPHssWdyayZIo5tsLgJH+fyQ86OpYUo
# SaNpB8YWqXG+RWm18hIzykWrwkLP0Hj1GvxYqyt/akovZWFwldfPVbfZMYICEjCC
# Ag4CAQEwcTBaMRUwEwYKCZImiZPyLGQBGRYFbG9jYWwxHTAbBgoJkiaJk/IsZAEZ
# Fg1UaGVOZXR3b3JrUHJvMSIwIAYDVQQDExlUaGVOZXR3b3JrUHJvLVROUERDLTAy
# LUNBAhMiAAAAAzhOV0cXwQ7aAAAAAAADMAkGBSsOAwIaBQCgeDAYBgorBgEEAYI3
# AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwGCisG
# AQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBSl8snKuuBb
# VehE7xfPkOJ2Sc4bqzANBgkqhkiG9w0BAQEFAASCAQCJ7zpHa2jYScEYK/+uH1/N
# cEKojwlBJnXiaYvReedVKZzs+1wadXlt1VfWTJTJed/oam0+fQHisJweEw472RyZ
# FJRSVNdDtpnnbvm1uA/Tw5h31gzoLawlNtGzDjdrRozJspCTaVI5Rp1nAdTaywd6
# uAhSdn/GdMYJcPul5Ec1uiz3wmU3/6dObe9bNBVx4GkoowCBQ9fzINd9TJuNxwO1
# U2wvqAiPS/y1p75SP+Bkfmb2RiKGLBHEA3bMl1YYNYV8JSJyNM0wAMCsJiyB3vEs
# 9XTh4NXdjErb8N6dtke2iuAOzTh9/8Tk7jEdcB/WBg5+pJUv/d8XOniJm4NnyjYX
# SIG # End signature block