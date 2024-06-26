# ZSH settings
{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    dotDir = ".config/zsh";
    history.path = "${config.home.homeDirectory}/.config/zsh/.zsh_history";

    # Aliases
    shellAliases = {
      nix-clean = "doas nix-collect-garbage";
      nix-switch = "doas nixos-rebuild switch --flake ${config.home.homeDirectory}/nixos#laptop";
      nix-rollback = "doas nixos-rebuild switch --flake ${config.home.homeDirectory}/nixos#laptop --rollback";
      cpf = "wl-copy <";
      lg = "lazygit";

      ls = "eza --git --icons $@";

      # Modern unix
      sudo = "doas $@";
    };

    envExtra = ''
    '';

    profileExtra = ''
    '';

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        src = pkgs.zsh-nix-shell;
      }
      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
      }
      {
        name = "zsh-autopair";
        file = "zsh-autopair.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
      }
      {
        name = "catppuccin-zsh-syntax-hightlighting";
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "zsh-syntax-highlighting";
          rev = "dbb1ec93b30dbe8cd728cffe0974aa7fa1ac3298";
          sha256 = "0B7g0J6+ZCoe1eErsSEmqO0aNOBi+FB+///vXnuiels=";
        };
        file = "themes/catppuccin_mocha-zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
        src = pkgs.zsh-syntax-highlighting;
      }
    ];
  };
  home.packages = with pkgs; [
    zsh-nix-shell
    zsh-completions
    zsh-autosuggestions
    zsh-syntax-highlighting
    eza
  ];
}
