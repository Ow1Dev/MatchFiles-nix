{ pkgs, ...
}: {
  home.packages = with pkgs; [
    docker-compose
    unzip
    httpie
  ];
}
