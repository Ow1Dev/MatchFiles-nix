{ pkgs, ...
}: {
  home.packages = with pkgs; [
    spotify

    docker-compose
    unzip
    httpie
  ];
}
