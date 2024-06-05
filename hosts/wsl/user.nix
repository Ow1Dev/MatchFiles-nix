{ config, pkgs, inputs, ... }:
{
  programs.zsh.enable = true;

  users.users.ow1 = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    home = "/home/ow1";
    shell = pkgs.zsh;
  };

  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        users = [ "ow1" ];
        keepEnv = true;
        persist = true;
      }];
    };
  };

  environment = {
    shells = [ pkgs.zsh ];

    systemPackages = with pkgs; [
      git
      wget
      home-manager
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
      ../../modulus/home
    ];
  };
} 
