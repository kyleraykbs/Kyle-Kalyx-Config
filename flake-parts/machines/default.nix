_: { config, inputs, lib, self, ... }:
let
  inherit (lib)
    mkOption
    types
    ;

  machine = 
  let 
    user = types.submodule {
      options = {
        stateVersion = mkOption {
          type = types.str;
          default = "23.11";
        };
        groups = mkOption {
          type = types.listOf types.str;
          default = [];
        };
        noSudoPassword = mkOption {
          type = types.bool;
          default = false;
        };
        roles = mkOption {
          type = types.listOf types.deferredModule;
          default = [];
        };
        configuration = mkOption {
          type = types.deferredModule;
        };
        # TODO: move stateversion here and in the system submodule too.
      };
    };
  in 
  types.submodule {
    options = {
      stateVersion = mkOption {
        type = types.str;
        default = "23.11";
      };

      nixosModules = mkOption {
        type = types.listOf types.deferredModule;
        default = [  ];
      };

      homeManagerModules = mkOption {
        type = types.listOf types.deferredModule;
        default = [  ];
      };

      configuration = mkOption {
        type = types.deferredModule;
      };

      users = mkOption {
        type = types.attrsOf user;
        default = [];
      };

      roles = mkOption {
        type = types.listOf types.deferredModule;
        default = [];
      };

      hardware = mkOption {
        type = types.deferredModule;
      };
    };
  };
in
{
  options = {
    machines = mkOption {
      type = types.attrsOf machine;
      default = { };
    };
  };

  config = 
  let
    mkHomeUserModule = machine: if machine.users == [] then [] else [ 
      inputs.home-manager.nixosModules.home-manager 
      {
        home-manager = {
          extraSpecialArgs = { inherit inputs self; };
          useGlobalPkgs = true;
          useUserPackages = true;
          sharedModules = machine.homeManagerModules;
        };
      }
    ] ++ (lib.attrsets.mapAttrsToList (name: configuration: {
      users.users.${name} = {
        isNormalUser = true;
        description = "${name}";
        extraGroups = configuration.groups;
      };

      security.sudo.extraRules = lib.mkIf configuration.noSudoPassword [
        { users = [ "${name}" ];
          commands = [
            { command = "ALL" ;
              options= [ "NOPASSWD" ];
            }
          ];
        }
      ];

      home-manager.users.${name} = {
        imports = [ configuration.configuration {home.stateVersion = configuration.stateVersion;} ] ++ configuration.roles;
      };
    }) machine.users);

    mkNixosConfiguration = hostname: machine: inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs self; };
      modules = [
        machine.hardware
        machine.configuration
        {system.stateVersion = machine.stateVersion;}
      ] 
      ++ machine.nixosModules
      ++ machine.roles
      ++ (mkHomeUserModule machine)
      ;
    };
  in 
  {
    flake = {      
      nixosConfigurations = lib.attrsets.mapAttrs (systemname: machine: mkNixosConfiguration systemname machine) config.machines;
    };
  };
}
