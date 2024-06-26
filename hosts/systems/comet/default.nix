#

{ config, pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./hardware.nix
  ];
  
  # Setup Kalyx functionality.
  kalyx = {
    # home-compatability.hyprland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    firefox
  ];

  networking.wireguard = {
    networks.asluni.autoConfig = {
      peers = true;
      interface = true;
    };
  };

  services = {
    syncthing = {
      enable = true;
      user = "kyle";
      dataDir = "/home/kyle/Documents";
      configDir = "/home/kyle/Documents/.config/syncthing";
      overrideDevices = true;     # overrides any devices added or deleted through the WebUI
      overrideFolders = true;     # overrides any folders added or deleted through the WebUI
      settings = {
        devices = {
          "phone" = { id = "PQZCAXZ-LI7YBGO-QWKRTMV-XFLKK5R-NUXIYKR-4W4ILPR-QDET2NI-LVNHEQ7"; };
          "borealis" = { id = ""; };
        };
        folders = {
          "Sync" = {
            path = "/home/kyle/Sync";
            devices = [ "phone" ];
            ignorePerms = true;
          };
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 7777 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 7777 ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
