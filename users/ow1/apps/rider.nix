{ config
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    jetbrains.rider
    dotnet-sdk_7
    dotnet-sdk_6
  ];
}
