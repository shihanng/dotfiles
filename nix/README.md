1. Install **Home Manager** from https://github.com/rycee/home-manager
2. For Linux:
```
ln -s `pwd`/arch-shihanng.nix $HOME/.config/nixpkgs/home.nix
home-manager switch
```

3. For Darwin (see: https://rycee.gitlab.io/home-manager/index.html#sec-install-nix-darwin-module). Need to install [`nix-darwin`](https://github.com/LnL7/nix-darwin).
```
darwin-rebuild switch -I darwin-config=$HOME/dotfiles/nix/darwin-shihan.ng.nix
```
