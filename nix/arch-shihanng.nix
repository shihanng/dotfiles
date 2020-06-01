{ ... }:

{
  home.username = "shihanng";
  home.homeDirectory = "/home/shihanng";
  services.lorri.enable = true;

  imports = [ ./home.nix ];
}
