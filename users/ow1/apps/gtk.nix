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
      package = (
        pkgs.catppuccin-gtk.override { 
          accents = [ "green" ];
          size = "standard";
          variant = "frappe"; 
        });
      name = "Catppuccin-Frappe-Standard-Green-Dark";
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

  home.sessionVariables.GTK_THEME = "Catppuccin-Frappe-Standard-Green-Dark";

  # cursor theme
  home.file.".icons/default".source = "${pkgs.catppuccin-cursors.mochaGreen}/share/icons/Catppuccin-Mocha-Green-Cursors";
}
