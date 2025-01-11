{
    description = "An OCaml development environment using NixOS flakes!";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
        utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, utils, ... }:
        utils.lib.eachDefaultSystem (system:
        let
            pkgs = import nixpkgs { inherit system; };
        in
        {
            devShell = with pkgs; mkShell {
                buildInputs = [
                    ocaml
                    dune_3
                    ocamlPackages.utop
                    ocamlPackages.lsp
                    zsh
                ];
            };
        }
    );
}
