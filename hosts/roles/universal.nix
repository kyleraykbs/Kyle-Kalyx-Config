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
  
  # Remove XTERM
  services.xserver.excludePackages = [ pkgs.xterm ];
  
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

  services.xserver = {
    xkb = {
      variant = "";
      layout = "us";
    };
  };
  
  nixpkgs.config.allowInsecurePredicate = pkg: lib.strings.hasPrefix "electron" (lib.getName pkg);

  environment.systemPackages = with pkgs; [
    lazygit
  ];

  programs.git.enable = true;
  security.rtkit.enable = true;

  environment.pathsToLink = [ "/share/zsh" ]; # ZSH
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.ohMyZsh.plugins = [ "git" "z" ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
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
