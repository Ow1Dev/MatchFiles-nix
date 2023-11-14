{ config
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    dotnet-sdk
    nodejs_20
    nodePackages.pnpm
  ];
}
