{lib, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = lib.strings.concatStrings [
        "$nix_shell"
        "$os"
        "$directory"
        "$container"
        "$git_branch $git_status"
        "$python"
        "$nodejs"
        "$lua"
        "$rust"
        "$java"
        "$c"
        "$golang"
        "$cmd_duration"
        "$status"
        "\n$character"
      ];
      git_branch.symbol = " ";
      git_commit.tag_disabled = false;
      git_status = {
        ahead = ''⇡''${count}'';
        behind = ''⇣''${count}'';
        diverged = ''⇕⇡''${ahead_count}⇣''${behind_count}'';
        staged = "+$count";
      };
      kubernetes.disabled = false;
      time.disabled = false;
    };
  };
}
