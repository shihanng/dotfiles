{ ... }:

{
  home.username = "shihanng";
  home.homeDirectory = "/home/shihanng";
  services.lorri.enable = true;

  # See https://github.com/rycee/home-manager/issues/1265
  systemd.user.services.lorri.Service.Environment = [ "NIX_PATH=${builtins.getEnv "NIX_PATH"}" ];

  imports = [ ./home.nix ];
}
