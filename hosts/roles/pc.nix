# This config will apply itself to all configs that subscribe to the 'pc' role.

{ config, pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [ ];
  
  # Setup Kalyx functionality.
  kalyx = { };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Set a kernel! Comment this out to get the regular Linux LTS kernel.
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_zen; 

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
