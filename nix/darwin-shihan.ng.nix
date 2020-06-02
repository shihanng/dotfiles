{ config, pkgs, ... }:

let
  inherit (pkgs) lorri;

in
{
  imports = [ <home-manager/nix-darwin> ];

  home-manager.useUserPackages = true;
  home-manager.users."shihan.ng" = { pkgs, ... }: {
    imports = [ ./home.nix ];
  };

  programs.zsh.enable = true;
  programs.gnupg.agent.enable = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      lorri
    ];

  # https://github.com/target/lorri/blob/3d5eb131a73d72963cb3ee0eee7ac0eca5321254/contrib/daemon.md#run-lorri-daemon-on-macOS-with-nix
  # https://github.com/target/lorri/issues/96#issuecomment-579931485
  launchd.user.agents = {
    "lorri" = {
      serviceConfig = {
        WorkingDirectory = (builtins.getEnv "HOME");
        EnvironmentVariables = {};
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/var/tmp/lorri.log";
        StandardErrorPath = "/var/tmp/lorri.log";
      };
      script = ''
        source ${config.system.build.setEnvironment}
        exec ${lorri}/bin/lorri daemon
      '';
    };
  };

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
