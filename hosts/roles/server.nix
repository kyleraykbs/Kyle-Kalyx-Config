# This config will apply itself to all configs that subscribe to the 'server' role.

{ config, pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [ ];
  
  # Setup Kalyx functionality.
  kalyx = {
    branding.enable = true; # Enable the Kalyx branding.
  };

  # Set a kernel! Comment this out to get the regular Linux LTS kernel.
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest; 

  environment.systemPackages = with pkgs; [ ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
