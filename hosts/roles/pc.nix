# This config will apply itself to all configs that subscribe to the 'pc' role.

{ config, pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [ ];
  
  # Setup Kalyx functionality.
  kalyx = { };

  # Enable SDDM.
  services.displayManager.sddm.enable = lib.mkDefault true;
  services.displayManager.sddm.wayland.enable = lib.mkDefault true;

  environment.systemPackages = with pkgs; [
    firefox
  ];
  
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
