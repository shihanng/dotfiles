{pkgs, ...}: {
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;
    home.packages = [
        pkgs.cowsay
    ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
