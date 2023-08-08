{ 
    config,
    pkgs,
    ...
}: {
    programs.tmux = {
        enable = true;
        shortcut = "a";
        baseIndex = 1;
        escapeTime = 0;
        extraConfig = ''
            set-option -a terminal-overrides ",*256col*:RGB"
            set -g status-style 'bg=#303446 fg=#a6d189'
            '';
        shell = "${pkgs.zsh}/bin/zsh";
        terminal = "xterm-256color";
    };

}
