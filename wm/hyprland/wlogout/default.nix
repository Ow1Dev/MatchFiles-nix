{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    wlogout
  ];

  xdg.configFile."wlogout".source = ./conf;
}
