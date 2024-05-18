{pkgs, lib, inputs, ...}:
let 
  modKey = "ALT";
in
{
  kalyx = { 
    thunar.enable = true;
    file-roller = {
      enable = true;
      default = true;  
    };
    imv.enable = true;
  };
  
  # Binds
  kalyx.tofi.bind = "${modKey},r";

  wayland.windowManager.hyprland.settings = {
    bind = [ # Kalyx doesn't provide a bindings setting as of current, so we use the default module.
      "${modKey},RETURN,exec,${pkgs.kitty}/bin/kitty"
      "${modKey},C,killactive"
      "${modKey},SPACE,togglefloating"
      "${modKey},M,exit"
      "${modKey},F,fullscreen"
    ];

    bindm = [
      "${modKey},mouse:272,movewindow"
      "${modKey},mouse:273,resizewindow"
    ];
  };
}
