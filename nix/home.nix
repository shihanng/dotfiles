{pkgs, ...}: {
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;
    home.packages = [
        pkgs.cowsay
    ];
}
