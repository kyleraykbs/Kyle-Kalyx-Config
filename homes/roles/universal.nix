{pkgs, lib, ...}: 
{
  programs.kitty.enable = true;

  kalyx = { };

  programs.git = {
    enable = true;
    userName = "kyleraykbs";
    userEmail = "kyleraykbs@proton.me";
  };
}