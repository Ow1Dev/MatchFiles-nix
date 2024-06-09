{ pkgs, inputs, ... }:

{
  programs.neovim = inputs.ow1dev-nvim.lib.mkHomeManager {
    system = pkgs.system;
  };
}
