- [Install Nix](https://nixos.org/download.html)
- Linux

  ```shell
  nix build --no-link ./flake.nix#homeConfigurations.shihanng.activationPackage
  "$(nix path-info ./flake#homeConfigurations.shihanng.activationPackage)"/activate
  ```

  ```
  home-manager switch --flake './flake.nix#shihanng'
  ```

- Darwin:
  ```shell
  nix build ./#darwinConfigurations.shihanng.system
  ./result/sw/bin/darwin-rebuild switch --flake ./#shihanng
  ```
