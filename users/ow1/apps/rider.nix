{ config
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    jetbrains.rider
    dotnet-sdk
    nodejs_20
    nodePackages.pnpm
  ];
}
