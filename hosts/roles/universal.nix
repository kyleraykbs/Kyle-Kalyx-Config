# This system config will apply itself to all systems.

{ config, pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [ ];
  
  # Setup Kalyx functionality.
  kalyx = {
    # Authentication toolkit setup for kalyx using gnome keyring and gnupg.
    authentication = {
      enable = true;
    };

    printing.enable = true;

    branding.enable = true; # Enable the Kalyx branding.
  };

  # TODO: Port to Kalyx module
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "ehci_hcd.ignore_oc=1"
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # services.xserver.enable = true;
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Set a kernel! Comment this out to get the regular Linux LTS kernel.
  boot.kernelPackages = pkgs.linuxPackages_zen; 

  environment.systemPackages = with pkgs; [
    lazygit
  ];

  programs.git.enable = true;
  security.rtkit.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
