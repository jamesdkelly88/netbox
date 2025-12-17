locals {

  choice_lists = {
    disk_speed = [
      ["fast","Fast"],
      ["slow","Slow"]
    ]
    keys = [
      ["F1", "F1"],
      ["F2", "F2"],
      ["F3", "F3"],
      ["F4", "F4"],
      ["F5", "F5"],
      ["F6", "F6"],
      ["F7", "F7"],
      ["F8", "F8"],
      ["F9", "F9"],
      ["F10", "F10"],
      ["F11", "F11"],
      ["F12", "F12"],
      ["Del", "Del"],
      ["Esc", "Esc"]
    ]
    patching = [
      ["alpine", "Alpine"],
      ["debian", "Debian"],
      ["macports", "MacPorts"],
      ["pihole", "Pi-Hole"],
      ["rhel", "Red Hat"],
      ["talos", "Talos"],
      ["wsus", "WSUS (Windows)"],
      ["xen", "Xen"]
    ]
    YN = [
      ["y","Y"],
      ["n","N"]
    ]
  }

  cidr = {
    mask   = 22
    prefix = "192.168"
    subnet = 88
  }

  clusters = [
    {
      type = "Nested",
      names = [
        "Gnome Boxes",
        "KubeVirt",
        "LibVirt ARM",
        "Openstack",
        "TrueNAS Scale"
      ]
    },
    {
      type  = "Self-hosted"
      names = [
        "Hyper-V",
        "Nested",
        "Proxmox",
        "ESXi",
        "XCP-ng"
      ]
    }
  ]

  colours = [
    "aa1409",
    "f44336",
    "e91e63",
    "ffe4e1",
    "ff66ff",
    "9c27b0",
    "673ab7",
    "3f51b5",
    "2196f3",
    "03a9f4",
    "00bcd4",
    "009688",
    "00ffff",
    "2f6a31",
    "4caf50",
    "8bc34a",
    "cddc39",
    "ffeb3b",
    "ffc107",
    "ff9800",
    "ff5722",
    "795548",
    "c0c0c0",
    "9e9e9e",
    "607d8b",
    "111111",
    "ffffff"
  ]

  custom_fields = [
    {
      name        = "Always On"
      default     = "n"
      description = ""
      choices     = "YN"
      classes     = ["dcim.device"]
      regex       = ""
      required    = true
      type        = "select"
    },
    {
      name        = "Ansible Roles"
      description = "Pipe-delimited"
      choices     = null
      classes     = ["dcim.device", "virtualization.virtualmachine"]
      regex       = ""
      required    = false
      type        = "text"
    },
    {

      name        = "BIOS Key"
      description = ""
      choices     = "keys"
      classes     = ["dcim.device"]
      regex       = ""
      required    = false
      type        = "select"
    },
    {
      name        = "Boot Order Key"
      description = ""
      choices     = "keys"
      classes     = ["dcim.device"]
      regex       = ""
      required    = false
      type        = "select"
    },
    {
      name        = "CPU"
      description = "CPU: Make Model ({Cores}x{Speed}GHz)"
      choices     = null
      classes     = ["dcim.device"]
      regex       = "^.+\\(\\d+x\\d.\\d+GHz\\)$"
      required    = false
      type        = "text"
    },
    {
      name        = "Last Patched"
      description = ""
      choices     = null
      classes     = ["dcim.device", "virtualization.virtualmachine"]
      regex       = ""
      required    = false
      type        = "date"
    },
    {
      name        = "Patching"
      description = ""
      choices     = "patching"
      classes     = ["dcim.device", "virtualization.virtualmachine"]
      regex       = ""
      required    = false
      type        = "select"
    },
    {
      name        = "RAM"
      description = "RAM (MB)"
      choices     = null
      classes     = ["dcim.device"]
      regex       = ""
      required    = false
      type        = "integer"
    },
    {
      name        = "Speed"
      default     = "slow"
      description = ""
      choices     = "disk_speed"
      classes     = ["virtualization.virtualdisk"]
      regex       = ""
      required    = true
      type        = "select"
    },
    {
      name        = "SSD"
      default     = "n"
      description = ""
      choices     = "YN"
      classes     = ["virtualization.virtualdisk"]
      regex       = ""
      required    = true
      type        = "select"
    },
    {
      name        = "Storage"
      description = "In GB with type, + separated (H=HDD, S=SSD, M=Memory card, U=USB, N=NVMe, D=DOM, E=eMMC)"
      choices     = null
      classes     = ["dcim.device"]
      regex       = "^[0-9]+[HSUMNDE](\\+[0-9]+[HSUMNDE])*$"
      required    = false
      type        = "text"
    },
    {
      name        = "Swap"
      description = "Swap (MB)"
      choices     = null
      classes     = ["virtualization.virtualmachine"]
      regex       = ""
      required    = false
      type        = "integer"
    },
  ]

  manufacturers = [
    "Acer",
    "Amazon",
    "Apple",
    "Asus",
    "D-Link",
    "Dell",
    "e-Machines",
    "Feit Electric",
    "Fujitsu",
    "GMKTec",
    "Google",
    "Hewlett Packard",
    "iOTA",
    "Lenovo",
    "LG",
    "Microsoft",
    "NEC",
    "Nintendo",
    "OrangePi",
    "Panasonic",
    "Philips",
    "Raspberry Pi Foundation",
    "Sagemcom",
    "Samsung",
    "Sony",
    "Toshiba",
    "TP Link"
  ]

  operating_systems = [
    {
      name     = "Bespoke"
      versions = [""]
    },
    {
      name     = "Android"
      versions = [""]
    },
    {
      name     = "ArcaOS"
      versions = [5]
    },
    {
      name     = "Armbian"
      versions = ["22.04"]
    },
    {
      name     = "Debian"
      versions = [11, 12, 13, 14, "Sid"]
    },
    {
      name     = "DietPi"
      versions = [9]
    },
    {
      name     = "Fedora"
      versions = [39]
    },
    {
      name     = "Harvester"
      versions = ["1.3"]
    },
    {
      name     = "iOS"
      versions = [""]
    },
    {
      name     = "Lubuntu"
      versions = ["22.04"]
    },
    {
      name     = "Mac OS"
      versions = [12, 13]
    },
    {
      name     = "Nix OS"
      versions = [""]
    },
    {
      name     = "Proxmox"
      versions = [7, 8]
    },
    {
      name     = "Raspbian"
      versions = []
    },
    {
      name     = "Red Hat Enterprise Linux"
      versions = [7, 8, 9, 10]
    },
    {
      name     = "Rocky Linux"
      versions = [9]
    },
    {
      name     = "Talos"
      versions = [""]
    },
    {
      name     = "TrueNAS Scale"
      versions = ["22.12"]
    },
    {
      name     = "Ubuntu"
      versions = ["22.04"]
    },
    {
      name     = "Ubuntu Server"
      versions = ["22.04"]
    },
    {
      name     = "Windows"
      versions = [10, 11]
    },
    {
      name     = "Windows Server"
      versions = [2016, 2019, 2022, 2025]
    },
    {
      name     = "XCP-ng"
      versions = ["8.2"]
    },
    {
      name     = "XOA"
      versions = [""]
    }
  ]

  prefixes = [
    {
      name = "Home"
      cidr = "192.168.88.0/22"
      site = "Home"
    },
    {
      name = "Managed"
      cidr = "192.168.88.0/24"
      site = "Home"
    },
    {
      name = "IoT"
      cidr = "192.168.89.0/24"
      site = "Home"
    },
    {
      name = "Virtual Machines"
      cidr = "192.168.90.0/24"
      site = "Home"
    },
    {
      name = "Guests"
      cidr = "192.168.91.0/24"
      site = "Home"
    }
  ]

  racks = [
    "Kallax Bottom-Left",
    "Kallax Bottom-Right",
    "Kallax-Top",
    "Kallax Top-Left",
    "Kallax Top-Right"
  ]

  ranges = [
    {
      name  = "Amazon"
      start = 201
      size  = 10
    },
    {
      name  = "DHCP Guests"
      start = 769
      size  = 254
    },
    {
      name  = "Desktops"
      start = 51
      size  = 10
    },
    {
      name  = "Games"
      start = 11
      size  = 10
    },
    {
      name  = "IoT"
      start = 241
      size  = 271
    },
    {
      name  = "Laptops"
      start = 61
      size  = 20
    },
    {
      name  = "Media"
      start = 81
      size  = 10
    },
    {
      name  = "Network"
      start = 1
      size  = 10
    },
    {
      name  = "Personal"
      start = 91
      size  = 20
    },
    {
      name  = "Printers"
      start = 221
      size  = 10
    },
    {
      name  = "SBCs"
      start = 21
      size  = 10
    },
    {
      name  = "Storage"
      start = 31
      size  = 10
    },
    {
      name  = "Tablets"
      start = 41
      size  = 10
    },
    {
      name  = "Virtual Machines"
      start = 512
      size  = 255
    }
  ]

  regions = [
    {
      name = "Europe"
      countries = [
        {
          name = "Germany"
          cities = [
            "Frankfurt"
          ]
        },
        {
          name = "United Kingdom"
          cities = [
            "London",
            "Sheffield"
          ]
        }
      ]
    }
  ]

  roles = [
    "Access Point",
    "Desktop",
    "E-reader",
    "Games Console",
    "Hypervisor",
    "LXC",
    "Laptop",
    "Managed Switch",
    "Media",
    "Mobile Phone",
    "Modem",
    "Power",
    "Printer",
    "Router",
    "SBC",
    "Smartwatch",
    "Storage",
    "Tablet",
    "Thin Client",
    "Unmanaged Switch",
    "VM",
    "IoT Bridge",
    "Smart Bulb",
    "Security Camera",
    "Smart Plug",
    "Vacuum Cleaner"
  ]

  rooms = [
    "Bedroom",
    "Hall",
    "Homelab",
    "Kitchen",
    "Living Room",
    "Office",
    "Wireless"
  ]

  sites = [
    {
      name   = "AWS Europe West 2"
      city   = "London"
      status = "active"
    },
    {
      name   = "Azure Germany West Central"
      city   = "Frankfurt"
      status = "staging"
    },
    {
      name   = "Home"
      city   = "Sheffield"
      status = "active"
    },
    {
      name   = "UpCloud uk-lon"
      city   = "London"
      status = "active"
    }
  ]
}