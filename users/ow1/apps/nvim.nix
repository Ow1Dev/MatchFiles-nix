{ pkgs
, ...
}: {
  xdg.configFile."nvim".source = ../confs/nvim;

  home.packages = with pkgs; [
    ripgrep
    lazygit
  ];

  home.file = {
    ".omnisharp/omnisharp.json".text = ''
      {
        "RoslynExtensionsOptions": {
          "enableDecompilationSupport": true
        }
      }
    '';
  };

  programs.neovim = {
    enable = true;

    plugins = with pkgs; [
      # languages
      vimPlugins.nvim-lspconfig
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.none-ls-nvim
      vimPlugins.rust-tools-nvim
      vimPlugins.omnisharp-extended-lsp-nvim

      # Autocompletion
      vimPlugins.nvim-cmp
      vimPlugins.cmp-buffer
      vimPlugins.cmp-path
      vimPlugins.cmp-nvim-lsp
      vimPlugins.cmp-nvim-lua
      vimPlugins.cmp-emoji
      vimPlugins.nvim-autopairs

      #Snippets
      vimPlugins.luasnip
      vimPlugins.cmp_luasnip
      vimPlugins.friendly-snippets

      # telescope
      vimPlugins.plenary-nvim
      vimPlugins.popup-nvim
      vimPlugins.telescope-nvim
      vimPlugins.telescope-fzf-native-nvim

      # theme
      vimPlugins.catppuccin-nvim
      vimPlugins.nvim-web-devicons

      # floaterm
      vimPlugins.vim-floaterm

      # extras
      vimPlugins.which-key-nvim
      vimPlugins.gitsigns-nvim
      vimPlugins.lualine-nvim
      vimPlugins.nerdcommenter
      vimPlugins.nvim-colorizer-lua
      vimPlugins.nvim-treesitter-context
      vimPlugins.nvim-tree-lua
      vimPlugins.comment-nvim
      vimPlugins.nvim-ts-context-commentstring
    ];

    extraConfig = ''
      lua << EOF
        require 'Ow1Dev'.init()
      EOF
    '';

    extraPackages = with pkgs; [
      # languages
      nodejs
      rustc

      # language servers
      gopls
      lua-language-server
      nil
      nodePackages."diagnostic-languageserver"
      nodePackages."typescript"
      nodePackages."typescript-language-server"
      nodePackages."vscode-langservers-extracted"
      nodePackages."yaml-language-server"
      nodePackages."svelte-language-server"
      omnisharp-roslyn
      rust-analyzer

      # formatters
      nixpkgs-fmt
      rustfmt

      # tools
      cargo
      gcc
    ];

    package = pkgs.neovim-unwrapped;
    vimAlias = false;
    viAlias = false;
    vimdiffAlias = false;
    withRuby = false;
    withNodeJs = false;
    withPython3 = false;
  };
}

