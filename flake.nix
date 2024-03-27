{
  description = "Template config using kalyx.";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kalyx = {
      url = "file:./kalyx?submodules=1";
      type = "git";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    kyler = {
      url = "file:./kyler?submodules=1";
      type = "git";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs@{ flake-parts, kalyx, ... }:
    flake-parts.lib.mkFlake { inherit inputs; }
      (toplevel@ {config, flake-parts-lib, ...}: #
      let
        inherit (flake-parts-lib) importApply;

        flakeModules = {
          machines = importApply ./flake-parts/machines toplevel;
        };
      in {
        imports = with flakeModules; [
          machines
        ];

        systems = [ "x86_64-linux" ];

        machines = {
          borealis = {
            nixosModules = [ kalyx.nixosModules.default ];
            homeManagerModules = [ kalyx.homeManagerModules.default inputs.kyler.homeManagerModules.default ];
            configuration = ./hosts/systems/borealis/default.nix;
            roles = [ ./hosts/roles/universal.nix ./hosts/roles/pc.nix ];
            hardware = ./hosts/systems/borealis/hardware.nix;
            stateVersion = "22.05";
            users = {
              kyle = {
                groups = [ "networkmanager" "wheel" "dialout" ] ++ kalyx.universalGroups ++ kalyx.adminGroups;
                noSudoPassword = true;
                configuration = ./homes/kyle/borealis.nix;
                roles = [ ./homes/kyle ./homes/roles/universal.nix ./homes/roles/pc.nix ];
              };
            };
          };
          stardust = {
            nixosModules = [ kalyx.nixosModules.default ];
            homeManagerModules = [ kalyx.homeManagerModules.default inputs.kyler.homeManagerModules.default ];
            configuration = ./hosts/systems/stardust/default.nix;
            roles = [ ./hosts/roles/universal.nix ./hosts/roles/pc.nix ];
            hardware = ./hosts/systems/stardust/hardware.nix;
            stateVersion = "22.05";
            users = {
              kyle = {
                groups = [ "networkmanager" "wheel" "dialout" ] ++ kalyx.universalGroups ++ kalyx.adminGroups;
                noSudoPassword = true;
                configuration = ./homes/kyle/stardust.nix;
                roles = [ ./homes/kyle ./homes/roles/universal.nix ./homes/roles/pc.nix ];
              };
            };
          };
          comet = {
            nixosModules = [ kalyx.nixosModules.default ];
            homeManagerModules = [ kalyx.homeManagerModules.default inputs.kyler.homeManagerModules.default ];
            configuration = ./hosts/systems/comet/default.nix;
            roles = [ ./hosts/roles/universal.nix ./hosts/roles/pc.nix ];
            hardware = ./hosts/systems/comet/hardware.nix;
            users = {
              kyle = {
                groups = [ "networkmanager" "wheel" "dialout" ] ++ kalyx.universalGroups ++ kalyx.adminGroups;
                noSudoPassword = true;
                configuration = ./homes/kyle/comet.nix;
                roles = [ ./homes/kyle ./homes/roles/universal.nix ./homes/roles/pc.nix ];
              };
            };
          };
        };
      });
}
