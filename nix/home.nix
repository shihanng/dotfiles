{ config, pkgs, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
    rnix-lsp
    terraform-ls
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

  programs.gpg.enable = true;

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
      (import ./nvim-plugins.nix { pkgs = pkgs; fetchgit = pkgs.fetchgit; }).vim-devicons
      (import ./nvim-plugins.nix { pkgs = pkgs; fetchgit = pkgs.fetchgit; }).night-owl
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
      direnv-vim
      emmet-vim
      fzfWrapper
      fzf-vim
      vim-terraform
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
      vim-rooter
      is-vim
      vim-asterisk
      gotests-vim
    ];
  };

  programs.tmux.enable = true;
  programs.tmux.secureSocket = false;
  programs.tmux.baseIndex = 1;
  programs.tmux.keyMode = "vi";
  programs.tmux.terminal = "xterm-256color";
  programs.tmux.shortcut = "q";
  programs.tmux.plugins = with pkgs ; [
    tmuxPlugins.sensible
    tmuxPlugins.vim-tmux-navigator
    tmuxPlugins.open
    tmuxPlugins.yank
    tmuxPlugins.pain-control
    tmuxPlugins.copycat
    {
      plugin = tmuxPlugins.prefix-highlight;
      extraConfig = ''
        set-option -g @prefix_highlight_show_copy_mode 'on'
      '';
    }
  ];
  programs.tmux.extraConfig = ''
    set-option -ga terminal-overrides ",xterm-256color:Tc,rxvt-unicode-256color:Tc"
    set -g default-command $SHELL
    set -g default-shell $SHELL

    # Use audible bell (faster response)
    set-option -g bell-action any
    set-option -g visual-bell off

    bind-key -T copy-mode-vi v send-keys -X begin-selection

    # Turn on mouse support
    set -g mouse on

    # direnv, see https://github.com/direnv/direnv/wiki/Tmux#alternatively
    set-option -g update-environment "DIRENV_DIFF DIRENV_DIR DIRENV_WATCHES"
    set-environment -gu DIRENV_DIFF
    set-environment -gu DIRENV_DIR
    set-environment -gu DIRENV_WATCHES
    set-environment -gu DIRENV_LAYOUT

    set-option -g status-position top
  '';
}
