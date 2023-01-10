{ pkgs, ... }: {
  home.packages = with pkgs; [
    brave
    vopono
  ];

}
