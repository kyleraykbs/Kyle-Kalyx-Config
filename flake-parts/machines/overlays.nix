{ inputs, pkgs, self, ... }:
with inputs;
let
  system = pkgs.stdenv.hostPlatform.system;

  overlay-unstable = final: prev: {
    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  };

  overlay-kyvim = final: prev: {
    kyvim = kyvim.packages.${system}.kyvim;
  };
in
{
  nixpkgs.overlays = [
    nur.overlay
    overlay-unstable
    overlay-kyvim
  ];
}
