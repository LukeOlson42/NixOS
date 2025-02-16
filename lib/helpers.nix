{ inputs }:
let
    # shamelessly stolen file
    my_lib = (import ./helpers.nix) { inherit inputs; };
    outputs = inputs.self.outputs;
in rec {

    pkgsFor = sys: inputs.nixpkgs.legacyPackages.${sys};

    mkSystem = config:
        inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {
                inherit inputs outputs my_lib;
            };

            modules = [
                config
                inputs.sddm-sugar-candy-nix.nixosModules.default
            ];
        };

    mkHome = sys: config:
        inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = pkgsFor sys;
            extraSpecialArgs = {
                inherit inputs my_lib outputs;
                inherit (inputs) textfox;
            };
            modules = [
                config
                inputs.textfox.homeManagerModules.default
            ];
        };

    forAllSystems = pkgs:
        inputs.nixpkgs.lib.genAttrs [
            "x86_64-linux"
            "aarch64-linux"
        ]
        (system: pkgs inputs.nixpkgs.legacyPackages.${system});
}
