# Drop your generated hardware config in here, along with any kalyx specific configuration options.

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  kalyx = {
    # GPU Options
    intelgpu.enable = lib.mkDefault false;
    amdgpu.enable = lib.mkDefault false;
    nvidia.enable = lib.mkDefault false;

    # CPU Options
    intel.enable = lib.mkDefault false;
    amd.enable = lib.mkDefault false;

    # Networking Options
    broadcom.enable = lib.mkDefault true;
  };

  # V Drop options of hardware-configuration.nix here V:
  
}
