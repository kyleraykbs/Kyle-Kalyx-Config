# Drop your generated hardware config in here, along with any kalyx specific configuration options.

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  kalyx = {
    printing.enable = true;

    # GPU Options
    intelgpu.enable = true;

    # CPU Options
    intel.enable = true;

    # Sound Options
    sound = {
      enable = true;
      soundServer = "pipewire";
    };

    bluetooth.enable = true;

    # Monitors
    monitors = [
      {
        resolution = "1600x900";
        framerate = 60;
        position = "0x0";
        adapter = "eDP-1";
        workspaces = [ 1 2 3 4 5 6 ];
        defaultWorkspace = 1;
        bitdepth = 10;
        primary = true;
      }
    ];

    defaultMonitor = {
      resolution = "preffered";
      position = "automatic";
    };

    camera = {
      enable = true;
      virtualCam = {
        enable = true;
        camNumbers = [8 9];
      };
    };
  };

  # V Drop options of hardware-configuration.nix here V:
  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/0aa34214-c84e-483f-a562-982bd6a6538f";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/ADFB-A8D5";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/0eee51f9-0aa0-4a19-a320-bbc6c930bb18"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s25.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
