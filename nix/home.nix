{ pkgs, ... }: {
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = with pkgs; [
    bitwarden-cli
    kustomize
    nil
    pgcli
    rnix-lsp
    vault
  ];

  programs.lazygit.enable = true;
  programs.lazygit.settings = {
    gui.theme = {
      selectedRangeBgColor = [ "reverse" ];
    };
    keybinding.universal = {
      quit = "q";
      return = "q";
    };
  };

  programs.exa.enable = true;
}

