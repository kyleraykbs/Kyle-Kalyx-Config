{pkgs, lib, ...}: 
let 
  modKey = "ALT";
in
{
  programs.kitty.enable = true;

  home.packages = with pkgs; [
    keepassxc
    firefox
    helvum
    obsidian
  ];

  kalyx = {
    hyprland = {
      enable = true;

      mappedBinds = {
        workspace = {
          bindMap = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "0" = "10";
          };
          binds = { # Binds are defined as a function that returns a string and accepts two arguments, where the arguments are provided by the bindMap attrset.
            moveFocusTo = x: y: "${modKey},${x},workspace,${y}"; # Once again, these names are arbitrary and are intended to provide convenience and self-documentation.
            moveWindowTo = x: y: "${modKey}+SHIFT,${x},movetoworkspace,${y}"; # Syntax is exactly the same as configuring Hyprland normally.
            moveWindowSilent = x: y: "${modKey}+CTRL,${x},movetoworkspacesilent,${y}";
          };
        };
      };
    };
    tofi = {
      enable = true;
    };
    vscode.enable = true;
    discord.enable = true;
    neofetch.enable = true;
  };

  kyler.colors = {
    base00 = "1d2021"; # ----
    base01 = "3c3836"; # ---
    base02 = "504945"; # --
    base03 = "665c54"; # -
    base04 = "bdae93"; # +
    base05 = "d5c4a1"; # ++
    base06 = "ebdbb2"; # +++
    base07 = "fbf1c7"; # ++++
    base08 = "fb4934"; # red
    base09 = "fe8019"; # orange
    base0A = "fabd2f"; # yellow
    base0B = "b8bb26"; # green
    base0C = "8ec07c"; # aqua/cyan
    base0D = "83a598"; # blue
    base0E = "d3869b"; # purple
    base0F = "d65d0e"; # brown
  };
  kyler.opacity = 90;
  kyler.autoEnable = true;

  programs = {
    obs-studio = {
      enable = true;
    };
  };
}
