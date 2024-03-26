# Drop your generated hardware config in here, along with any kalyx specific configuration options.

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  kalyx = {
    # GPU Options
    amdgpu.enable = true;
    #gpu.enable = true;

    # CPU Options
    intel.enable = true;

    # Sound Options
    sound = {
      enable = true;
      soundServer = "pipewire";
    };

    # Networking Options
    broadcom.enable = true;

    bluetooth.enable = true;

    # Monitors
    monitors = [
      {
        resolution = "1920x1080";
        framerate = 60;
        position = "1024x0";
        adapter = "HDMI-A-1";
        workspaces = [1 2 3 7 8 9];
        defaultWorkspace = 1;
        bitdepth = 10;
      }

      {
        resolution = "1280x1024";
        framerate = 60;
        position = "0x0";
        rotation = 90;
        adapter = "DVI-D-1";
        workspaces = [4 5 6];
        defaultWorkspace = 1;
        primary = true;
        bitdepth = 10;
      }
    ];

    defaultMonitor = {
      resolution = "preffered";
      position = "automatic";
    };

    virtualisation = {
      acspatch = true;
      cpuarch = "intel";
      virtcpus = "6-23";
      hostcpus = "0-23";
      enable = true;
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
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  boot.initrd.supportedFilesystems = ["nfs"];

  hardware.enableRedistributableFirmware = true;

    # Setup keyfile
  # boot.initrd.secrets = {
  #   "/crypto_keyfile.bin" = null;
  # };

  # # Enable swap on luks
  # boot.initrd.luks.devices."luks-0646a84a-36f8-48e4-8666-1e3d3570d79a".device = "/dev/disk/by-uuid/0646a84a-36f8-48e4-8666-1e3d3570d79a";
  # boot.initrd.luks.devices."luks-0646a84a-36f8-48e4-8666-1e3d3570d79a".keyFile = "/crypto_keyfile.bin";

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s25.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/13246881-9974-4a48-b481-a7f7e0f0f4ff";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E4BC-DCE6";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/4ad75aa8-f1e3-4cc7-8fc2-c34040cb1034"; }
    ];
}
