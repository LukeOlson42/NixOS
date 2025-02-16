{
	description = "Luke's NixOS Flake!";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

  		home-manager = {
  			url = "github:nix-community/home-manager";
  			inputs.nixpkgs.follows = "nixpkgs";
  		};

        hyprland = {
            url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        sddm-sugar-candy-nix = {
            url = "github:Zhaith-Izaliel/sddm-sugar-candy-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        textfox = {
            url = "github:adriankarlen/textfox";
            inputs.nixpkgs.follows = "nixpkgs";
        };
	};

	outputs = {
        self,
        nixpkgs,
        sddm-sugar-candy-nix,
        home-manager,
        hyprland,
        ...
    }@inputs:
	let
        # system type
        sys = "x86_64-linux";
        # main username
        username = "lukeolson";
        specialArgs = { inherit username inputs; };
	in
	{
        nixosConfigurations = {
            main-desktop = nixpkgs.lib.nixosSystem {
                inherit specialArgs;
                system = sys;
                modules = [
                    ./machines/desktop
                    sddm-sugar-candy-nix.nixosModules.default
                    home-manager.nixosModules.default
                ];
            };
        };
	};
}
