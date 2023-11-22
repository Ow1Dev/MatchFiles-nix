{ pkgs
, config
, inputs
, ...
}: {
  home.packages = with pkgs; [ glib ]; # gsettings
  xdg.systemDirs.data =
    let
      schema = pkgs.gsettings-desktop-schemas;
    in
    [ "${schema}/share/gsettings-schemas/${schema.name}" ];

  gtk = {
    enable = true;
    theme = {
      name = "Generated";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "green" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "frappe";
      };
    };
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "green";
      };
      name = "Papirus-Dark";
    };
    font = {
      name = "FantasqueSansMono Nerd Font";
      size = 13;
    };
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-application-prefer-dark-theme = 0;
    };
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };

  home.sessionVariables.GTK_THEME = "Generated";

  # cursor theme
  home.file.".icons/default".source = "${pkgs.catppuccin-cursors.mochaGreen}/share/icons/Catppuccin-Mocha-Green-Cursors";
}

