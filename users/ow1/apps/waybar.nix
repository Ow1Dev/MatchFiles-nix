{ ...
}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin = "0 0 0 0";
        modules-left = [ "hyprland/workspaces" "tray" ];
        modules-center = [ "clock" ];
        modules-right = [ "backlight" "pulseaudio" "battery" "network" ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = { default = ""; };
        };

        tray = {
          icon-size = 14;
          spacing = 5;
        };

        clock = {
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
            actions = {
              on-click-right = "mode";
              on-click-forward = "tz_up";
              on-click-backward = "tz_down";
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };
          format = "  {:%a. %d %b.   %H:%M}";
          format-alt = "  {:%d %m %Y   %H:%M}";
          interval = 60;
        };

        memory = {
          format = " {: >3}%";
          on-click = "kitty -e htop";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity: >3}%";
          format-icons = [ "󰁺" "󰁼" "󰁾" "󰂀" "󰁹" ];
          format-charging = "󰂄 charging";
          format-plugged = "󰂄 charging";
        };

        network = {
          format = "⚠  Disabled";
          format-wifi = "  {essid}";
          format-ethernet = "  Wired";
          format-disconnected = "⚠  Disconnected";
          on-click = "nm-connection-editor";
        };

        pulseaudio = {
          scroll-step = 1;
          format = "{icon} {volume: >3}%";
          format-bluetooth = "{icon} {volume: >3}%";
          format-muted = " muted";
          format-icons = {
            headphones = "";
            handsfree = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" ];
          };
          on-click = "pavucontrol";
          on-scroll-up = "amixer set Master 5%+";
          on-scroll-down = "amixer set Master 5%-";
        };

        backlight = {
          format = "{icon} {percent: >3}%";
          format-icons = ["" ""];
          on-scroll-down = "brightnessctl s -5%";
          on-scroll-up = "brightnessctl s +5%";
        };
      };
    };

    style = builtins.readFile ../confs/waybar/style.css;
  };

  xdg.configFile."waybar/frappe.css".text =
    builtins.readFile ../confs/waybar/frappe.css;
}
