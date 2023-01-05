{
  description = "Environment setup for dotfiles";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          devShells.default = with pkgs;
            mkShell {
              buildInputs = [
                nixpkgs-fmt
                pkgs.ansible-language-server
                pkgs.ansible-lint
                pkgs.lua53Packages.luacheck
                pkgs.stylua
                pkgs.sumneko-lua-language-server
              ];

              shellHook = ''
                # ...
              '';
            };
        }
      );
}
