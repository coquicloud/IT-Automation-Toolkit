<#
.SYNOPSIS
    Sends 'Magic Packets' to wake up PCs.
    
.DESCRIPTION
    Broadcasts a WoL magic packet to the subnet.
    Modify $MacAddress target.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

param(
    [string]$MacAddress = "00-11-22-33-44-55",
    [string]$IpAddress = "255.255.255.255",
    [int]$Port = 9
)

Write-Host "--- Wake-on-LAN Trigger ---" -ForegroundColor Cyan

try {
    $Mac = [System.Net.NetworkInformation.PhysicalAddress]::Parse($MacAddress.ToUpper().Replace(":", "-").Replace(".", "-"))
    $MacBytes = $Mac.GetAddressBytes()
    
    # Magic Packet = 6x FF + 16x MAC
    $Packet = [byte[]](, 0xFF * 6) + ($MacBytes * 16)
    
    $Client = New-Object System.Net.Sockets.UdpClient
    $Client.Connect($IpAddress, $Port)
    $Client.Send($Packet, $Packet.Length) | Out-Null
    $Client.Close()
    
    Write-Host "Magic Packet sent to $MacAddress" -ForegroundColor Green
}
catch {
    Write-Error "Failed to send packet: $($_.Exception.Message)"
}
