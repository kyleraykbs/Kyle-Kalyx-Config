# This config will apply itself to all configs that subscribe to the 'server' role.

{ config, pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [ ];
  
  # Setup Kalyx functionality.
  kalyx = {
    # Enable sound with pipewire or pulse.
    sound = {
      enable = true;
      soundServer = "pipewire"; # This can be 'pipewire' (default) or 'pulse'.
    };                          # NOTE: Pipewire can be enabled seperetly without audio using 'kalyx.pipewire.enable = true';
    
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
