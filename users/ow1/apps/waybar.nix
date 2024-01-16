{ config
, pkgs
, lib
, inputs
, ...
}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [ "clock" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "pulseaudio" "network" "battery"  "tray" ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          sort-by-name = true;
          format = "{icon}";
          format-icons = { default = ""; };
        };

        pulseaudio = {
          format = " {icon} ";
          format-muted = "󰝟";
          format-icons = [ "" "󰕾" "" ];
          tooltip = true;
          tooltip-format = "{volume}%";
          on-click = "amixer set Master toggle";
        };

        network = {
          format-wifi = " ";
          format-disconnected = "睊";
          format-ethernet = " ";
          tooltip = true;
          tooltip-format = "{signalStrength}%";
        };

        backlight = {
          device = "intel_backlight";
          format = "{icon}";
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
          tooltip = true;
          tooltip-format = "{percent}%";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-charging = "󰂄";
          format-plugged = "󰂄";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁼" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          tooltip = true;
          tooltip-format = "{capacity}%";
        };

        clock = {
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          format-alt = '' {:%d %m %Y}'';
          format = '' {:%H %M}'';
        };

        tray = {
          icon-size = 21;
          spacing = 10;
        };
      };
    };

    style = builtins.readFile ../confs/waybar/style.css;
  };

  xdg.configFile."waybar/frappe.css".text =
    builtins.readFile ../confs/waybar/frappe.css;
}
