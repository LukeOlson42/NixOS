{
    description = "A VTR development environment using Nix flakes!";

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
            # TODO: Make as many of these flake inputs as possible
                buildInputs = [
                    gnumake
                    cmake
                    pkg-config
                    bison
                    flex
                    python3
                    ninja

                    gtk3
                    xorg.libX11

                    tcl
                    gawk
                    xdot
                    readline
                    libffi
                    graphviz
                    boost
                    zlib
                    sphinx

                    libxslt
                    libxml2
                    gfortran9
                    openblas
                    openblasCompat
                ];

                shellHook = ''
                    echo "Verilog to Routing - Nix Shell"
                '';
            };

        }
    );
}
