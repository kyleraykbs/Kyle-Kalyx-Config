{ config, pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./hardware.nix
  ];
  
  # Setup Kalyx functionality.
  kalyx = { };

  environment.systemPackages = with pkgs; [
    firefox
  ];

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
          "comet" = { id = ""; };
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
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 7777 ];
  # networking.firewall.allowedUDPPorts = [ 7777 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
