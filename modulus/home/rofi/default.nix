{ config, pkgs, ... }:
let
  rofi-powermenu = pkgs.writeTextFile {
    name = "rofi_powermenu";
    destination = "/bin/powermenu";
    executable = true;
    text = builtins.readFile ./scripts/powermenu.sh;
  };
in
{
  home.packages = [ rofi-powermenu ];
  programs.rofi = {
    enable = true;
    package =
      pkgs.rofi-wayland.overrideAttrs
        (oldAttrs: { mesonFlags = [ "-Dxcb=disabled" ]; });
    extraConfig = {
      modi = "run,drun,window";
      icon-theme = "Papirus-Dark";
      show-icons = true;
      terminal = "kitty";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 﩯  Window";
      display-Network = " 󰤨  Network";
      sidebar-mode = true;
      font = "FantasqueSansMono Nerd Font 14";
    };
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          bg-col = mkLiteral "#303446";
          bg-col-light = mkLiteral "#303446";
          border-col = mkLiteral "#303446";
          selected-col = mkLiteral "#303446";
          green = mkLiteral "#a6d189";
          fg-col = mkLiteral "#c6d0f5";
          fg-col2 = mkLiteral "#e78284";
          grey = mkLiteral "#e78284";

          width = mkLiteral "600";
        };

        "element-text, element-icon , mode-switcher" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };

        "window" = {
          height = mkLiteral "360px";
          border = mkLiteral "3px";
          border-color = mkLiteral "@border-col";
          background-color = mkLiteral "@bg-col";
        };

        "mainbox" = {
          background-color = mkLiteral "@bg-col";
        };

        inputbar = {
          children = mkLiteral "[prompt,entry]";
          background-color = mkLiteral "@bg-col";
          border-radius = mkLiteral "5px";
          padding = mkLiteral "2px";
        };

        prompt = {
          background-color = mkLiteral "@green";
          padding = mkLiteral "6px";
          text-color = mkLiteral "@bg-col";
          border-radius = mkLiteral "3px";
          margin = mkLiteral "20px 0px 0px 20px";
        };

        textbox-prompt-colon = {
          expand = false;
          str = ":";
        };

        entry = {
          padding = mkLiteral "6px";
          margin = mkLiteral "20px 0px 0px 10px";
          text-color = mkLiteral "@fg-col";
          background-color = mkLiteral "@bg-col";
        };

        listview = {
          border = mkLiteral "0px 0px 0px";
          padding = mkLiteral "6px 0px 0px";
          margin = mkLiteral "10px 0px 0px 20px";
          columns = 2;
          lines = 5;
          background-color = mkLiteral "@bg-col";
        };

        element = {
          padding = mkLiteral "5px";
          background-color = mkLiteral "@bg-col";
          text-color = mkLiteral "@fg-col";
        };

        element-icon = {
          size = mkLiteral "25px";
        };

        "element selected" = {
          background-color = mkLiteral "@selected-col";
          text-color = mkLiteral "@fg-col2";
        };

        mode-switcher = {
          spacing = 0;
        };

        button = {
          padding = mkLiteral "10px";
          background-color = mkLiteral "@bg-col-light";
          text-color = mkLiteral "@grey";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.5";
        };

        "button selected" = {
          background-color = mkLiteral "@bg-col";
          text-color = mkLiteral "@green";
        };

        message = {
          background-color = mkLiteral "@bg-col-light";
          margin = mkLiteral "2px";
          padding = mkLiteral "2px";
          border-radius = mkLiteral "5px";
        };

        textbox = {
          padding = mkLiteral "6px";
          margin = mkLiteral "20px 0px 0px 20px";
          text-color = mkLiteral "@green";
          background-color = mkLiteral "@bg-col-light";
        };
      };
  };
}
