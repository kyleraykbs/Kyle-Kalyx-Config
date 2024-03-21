# Drop your generated hardware config in here, along with any kalyx specific configuration options.

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  kalyx = {
    # GPU Options
    intelgpu.enable = lib.mkDefault false;
    amdgpu.enable = lib.mkDefault false;
    nvidia.enable = true;

    # CPU Options
    intel.enable = lib.mkDefault false;
    amd.enable = true;
    
    # Sound Options
    sound = {
      enable = true;
      soundServer = "pipewire"; # This can be 'pipewire' (default) or 'pulse'.
    };                          # NOTE: Pipewire can be enabled seperetly without audio using 'kalyx.pipewire.enable = true';

    # Networking Options
    broadcom.enable = lib.mkDefault false;

    # Monitors
    monitors = [
      {
        resolution = "1920x1080";
        framerate = 60;
        position = "0x0";
        adapter = "DP-1";
        workspaces = [7 8 9];
        defaultWorkspace = 7;
        bitdepth = 10;
      }

      {
        resolution = "1920x1080";
        framerate = 120;
        position = "1920x0";
        adapter = "DP-2";
        workspaces = [1 2 3];
        defaultWorkspace = 1;
        primary = true;
        bitdepth = 10;
      }

      {
        resolution = "1920x1080";
        framerate = 60;
        position = "3840x0";
        adapter = "DVI-D-1";
        workspaces = [4 5 6];
        defaultWorkspace = 4;
        bitdepth = 10;
      }
    ];

    defaultMonitor = {
      resolution = "preffered";
      position = "automatic";
    };

    scream = {
      enable = true;
      unicast = true;
    };
  };

  # V Drop options of hardware-configuration.nix here V:
  networking = { 
    useDHCP = false;

    interfaces = {
      eno1.useDHCP = true;
      br0.useDHCP = true;
    };

    bridges = {
      "br0" = {
        interfaces = [ "eno1" ];
      };
    };
  }; # TODO: move this to virtualization module

  kalyx.virtualisation = {
    vfioids = [
      "10de:2805"
      "10de:22bd"
      "1022:43bb"
    ];
    acspatch = true;
    cpuarch = "amd";
    virtcpus = "20-23";
    hostcpus = "0-23";
    enable = true;
  };

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    };  
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d143e2cf-d65f-41f6-b96a-dd2fd1e4cd90";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7255-9D85";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/907492c7-2d87-49c9-8563-d60fccc44f7e"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
