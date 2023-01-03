- [Install Nix](https://nixos.org/download.html)
- Linux

  ```shell
  nix build --no-link ./#homeConfigurations.shihanng.activationPackage
  "$(nix path-info ./#homeConfigurations.shihanng.activationPackage)"/activate
  ```

  ```
  home-manager switch --flake './#shihanng'
  ```

- Darwin:
  ```shell
  nix build ./#darwinConfigurations.shihanng.system
  ./result/sw/bin/darwin-rebuild switch --flake ./#shihanng
  ```
