class win_rdp {

  registry_value { 'HKLM\System\CurrentControlSet\Control\Terminal Server\fDenyTSConnections':
    ensure => present,
    type   => dword,
    value  => "0",
  }

  registry_value { 'HKLM\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\UserAuthentication':
    ensure => present,
    type   => dword,
    value  => "0",
  }

  exec { 'turn off firewall':
    command  => '$(netsh advfirewall set currentprofile state off)',
    onlyif   => ' if ((netsh advfirewall show currentprofile | Select-String "State" | Out-String).Replace(" ","").Replace("State","").Replace("`r`n","") = "ON" { exit 0 }',
    provider => powershell,
  }
}
