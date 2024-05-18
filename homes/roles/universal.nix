{pkgs, lib, inputs, ...}: 
{
  programs.kitty.enable = true;

  kalyx = { };

  programs.git = {
    enable = true;
    userName = "kyleraykbs";
    userEmail = "kyleraykbs@proton.me";
  };
  
  home.packages = with pkgs; [
    kyvim
    keepassxc
    authenticator
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  
  xdg.mimeApps.enable = true; # Enable support for default apps. 

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    enableVteIntegration = true;
    completionInit = "autoload -U compinit && compinit";
    history.expireDuplicatesFirst = true;
    history.extended = true;
    oh-my-zsh = {
      enable = true;
      custom = "${pkgs.spaceship-prompt}/share/zsh";
      theme = "spaceship";
      extraConfig = ''
        SPACESHIP_JOBS_AMOUNT_THRESHOLD=0
        SPACESHIP_ASYNC_SHOW=false
        SPACESHIP_USER_SHOW=true
      '';
    };
  };
}
