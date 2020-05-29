{ config, pkgs, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;

  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.oh-my-zsh.plugins = [ "git" "zsh-interactive-cd" ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  home.packages =  with pkgs; [
    htop
    starship
  ];

  programs.starship.enable = true;

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
  programs.zsh.plugins = [
    {
      name = "select_cdr";
      src = ~/dotfiles/nix/zsh_plugins;
      file = "select_cdr.zsh";
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
}
