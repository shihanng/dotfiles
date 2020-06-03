{ config, pkgs, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;

  programs.zsh.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    FZF_COMPLETION_TRIGGER = "''";
  };

  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.oh-my-zsh.plugins = [
    "vi-mode"
    "git"
    "zsh-interactive-cd"
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  nixpkgs.overlays = [
    (
      self: super: {
        gotests = super.callPackage ./test.nix {};
      }
    )
  ];

  home.packages = with pkgs; [
    gotests
    htop
    nodejs
    pipenv
    pythonPackages.autopep8
    rnix-lsp
    starship
    tig
    tree
  ];

  home.file = {
    coc-settings = {
      recursive = true;
      source = ./coc-settings.json;
      target = ".config/nvim/coc-settings.json";
    };
    snippets = {
      recursive = true;
      source = ./ultisnips;
      target = ".config/coc/ultisnips";
    };
  };

  programs.man.enable = false;
  home.extraOutputsToInstall = [ "man" ];
  home.sessionVariables = {
    LANG = "en_US.UTF-8";
  };

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;

  programs.dircolors.enable = true;
  programs.dircolors.enableZshIntegration = true;


  programs.starship.enable = true;

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
  programs.fzf.defaultCommand = "fd --type f --hidden --follow --exclude .git";
  programs.fzf.defaultOptions = [ "--sort 20000" ];

  programs.gpg.enable = true;

  programs.zsh.plugins = [
    {
      name = "select_cdr";
      src = ~/dotfiles/nix/zsh_plugins;
      file = "select_cdr.zsh";
    }
    {
      name = "select_git_checkout";
      src = ~/dotfiles/nix/zsh_plugins;
      file = "select_git_checkout.zsh";
    }
    {
      name = "fzf";
      src = ~/dotfiles/nix/zsh_plugins;
      file = "fzf.zsh";
    }
    {
      name = "pet";
      src = ~/dotfiles/nix/zsh_plugins;
      file = "pet.zsh";
    }
    {
      name = "nvm";
      src = ~/dotfiles/nix/zsh_plugins;
      file = "nvm.zsh";
    }
    {
      name = "zsh-cdr";
      file = "cdr.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "willghatch";
        repo = "zsh-cdr";
        rev = "253c8e7ea2d386e95a4f06a78c660b3deee84bb7";
        sha256 = "197rrfzphv4nj943hhnbrigaz4vq49h7zddrdm06cdpq3m98xz0a";
      };
    }
  ];

  programs.neovim.enable = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;
  programs.neovim.vimdiffAlias = true;
  programs.neovim.configure = {
    customRC = ''
      ${builtins.readFile ./vim.vim}
    '';
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/vim-plugins/generated.nix
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/vim-plugins/overrides.nix
    plug.plugins = with pkgs.vimPlugins; [
      (import ./nvim-plugins.nix { pkgs = pkgs; fetchgit = pkgs.fetchgit; }).fzf
      (import ./nvim-plugins.nix { pkgs = pkgs; fetchgit = pkgs.fetchgit; }).gotests-vim
      (import ./nvim-plugins.nix { pkgs = pkgs; fetchgit = pkgs.fetchgit; }).vim-devicons
      (import ./nvim-plugins.nix { pkgs = pkgs; fetchgit = pkgs.fetchgit; }).vim-nerdtree-syntax-highlight
      auto-pairs
      coc-nvim
      coc-eslint
      coc-fzf
      coc-json
      coc-prettier
      coc-python
      coc-snippets
      coc-tslint-plugin
      coc-tsserver
      emmet-vim
      fzf-vim
      nerdtree
      nerdtree-git-plugin
      nord-vim
      syntastic
      vim-airline
      vim-airline-themes
      vim-commentary
      vim-fugitive
      vim-gitgutter
      vim-go
      vim-polyglot
      vim-snippets
      vim-surround
      vim-tmux-navigator
      vim-rhubarb
    ];
  };
}
