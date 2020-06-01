{ ... }:

{
  home.username = "shihanng";
  home.homeDirectory = "/home/shihanng";
  home.services.lorri.enable = true;

  imports = [ ./home.nix ];
}
