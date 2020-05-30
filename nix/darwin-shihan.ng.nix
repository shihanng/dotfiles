{ config, pkgs, ... }:

{
  imports = [<home-manager/nix-darwin>];

  home-manager.useUserPackages = true;
  home-manager.users."shihan.ng" = { pkgs, ... }: {
    imports = [./home.nix];
  };

  programs.zsh.enable = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.vim
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/dotfiles/nix/darwin-shihan.ng.nix
  environment.darwinConfig = "$HOME/dotfiles/nix/darwin-shihan.ng.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 1;
  nix.buildCores = 1;
}
