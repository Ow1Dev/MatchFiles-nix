{ config , pkgs , lib , inputs , ...  }: 
{
  users.users.ow1 = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    home = "/home/ow1";
    packages = with pkgs; [
      firefox
      kitty
      waybar
      pcmanfm
    ];
    shell = pkgs.zsh;
  };  

  environment = {
    shells = [ pkgs.zsh ];

    systemPackages = with pkgs; [
      git
      wget
      home-manager
      pipewire
      pulseaudio
      zsh
    ];

    pathsToLink = [ "/share/zsh" ];
  };

  home-manager.users.ow1 = {
    home = rec {
      inherit (config.system) stateVersion;
      username = "ow1";
      homeDirectory = "/home/${username}";
    };

    _module.args = { inherit inputs; };

    imports = [
      ./env.nix
      ./packages
      ./apps
    ];
  };
} 
