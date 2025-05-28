#Requires -Module Pester -Version 5
#Requires -Module PSPostgres

BeforeDiscovery {

    $env_file = Get-Content -Path "$PSScriptRoot/../.env"

    $DB_HOST = $env_file.Where{ $_ -like "DB_HOST=*"}.split("=")[1]
    $DB_NAME = $env_file.Where{ $_ -like "DB_NAME=*"}.split("=")[1]
    $DB_USER = $env_file.Where{ $_ -like "DB_USER=*"}.split("=")[1]
    $DB_PASSWORD = $env_file.Where{ $_ -like "DB_PASSWORD=*"}.split("=")[1]

    $connection_string   = "Server=$($DB_HOST);Database=$($DB_NAME);User Id=$($DB_USER);Password=$($DB_PASSWORD)"
    Write-Host $connection_string
    $connection          = Connect-Postgres -ConnectionString $connection_string

    $data = @{
        cables = Invoke-PostgresQuery -Connection $connection -Query @"
SELECT *
FROM dcim_cable
"@
        devices = Invoke-PostgresQuery -Connection $connection -Query @"
SELECT d.*, 
dr.name as device_role_name 
FROM dcim_device d 
LEFT JOIN dcim_devicerole dr ON d.role_id = dr.id
"@
        interfaces = Invoke-PostgresQuery -Connection $connection -Query @"
SELECT i.*, 
d.name as device_name,
CASE
  WHEN type LIKE 'ieee802%' THEN 'wireless'
  ELSE 'wired'
END as type_class
FROM dcim_interface i
LEFT JOIN dcim_device d on i.device_id = d.id
"@
        ip_addresses = Invoke-PostgresQuery -Connection $connection -Query @"
SELECT *
FROM ipam_ipaddress
"@
    }
}

Describe "Cables" {
    Context "<_.id>" -ForEach $data.cables {
        It "Should have a label" {
            $_.label | Should -Not -BeNullOrEmpty
        }
        It "Should have a type" {
            $_.type | Should -Not -BeNullOrEmpty
        }
        It "Should have a colour" {
            $_.color | Should -Not -BeNullOrEmpty
        }
        It "Should have a length" {
            $_.length | Should -Not -BeNullOrEmpty
        }
        It "Should have a length in meters" {
            $_.length_unit | Should -Be "m"
        }
    }
}
Describe "Devices" {
    Context "<_.name>" -ForEach $data.devices {
        It "Should have a name in uppercase" {
            $_.name -ceq $_.name.ToUpper()
        }
        It "Should have a serial number" {
            $_.serial | Should -not -BeNullOrEmpty
        }
        It "Should have a role" {
            $_.role_id | Should -not -BeNullOrEmpty
        }
        It "Should have a device type" {
            $_.device_type_id | Should -not -BeNullOrEmpty
        }
        It "Should have a location" {
            $_.location_id | Should -not -BeNullOrEmpty
        }
        It "Should have a platform" {
            if($_.device_role_name -notin @("Unmanaged Switch"))
            {
                $_.platform_id | Should -not -BeNullOrEmpty
            }
        }
        It "Should have an IP address" {
            if($_.device_role_name -notin @("Modem","Unmanaged Switch"))
            {
                $_.primary_ip4_id | Should -not -BeNullOrEmpty
            }
        }   
        It "Should be in a rack" {
            $_.rack_id | Should -not -BeNullOrEmpty
        }
        It "Should have a site" {
            $_.site_id | Should -not -BeNullOrEmpty
        }
        It "Should have an interface" {
            $_.interface_count | Should -BeGreaterThan 0
        }
    }
}
Describe "Interfaces" {
    Context "<_.device_name>.<_.name>" -ForEach $data.interfaces {
        It "Should have a type" {
            $_.type | Should -Not -BeNullOrEmpty
        }
        It "Should have a primary mac address" {
            if($_.device_role_name -notin @("Unmanaged Switch"))
            {
                $_.primary_mac_address_id | Should -Not -BeNullOrEmpty
            }
        }
        It "Should have a cable connected if wired and enabled" {
            if($_.enabled -eq $true -and $_.type_class -eq "wired")
            {
                $_.cable_id | Should -Not -BeNullOrEmpty
            }
        }
    }
}

Describe "IP Addresses" {
    Context "<_.address>" -ForEach $data.ip_addresses {
        It "Should be assigned" {
            $_.assigned_object_id | Should -Not -BeNullOrEmpty
        }
    }
}