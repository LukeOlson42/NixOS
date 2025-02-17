{
	description = "Luke's NixOS Flake!";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

  		home-manager = {
  			url = "github:nix-community/home-manager/release-24.11";
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
        home-manager,
        ...
    }@inputs:
	let
        # system type
        system = "x86_64-linux";
        # main username
        username = "lukeolson";
        specialArgs = { inherit username inputs; };
	in
	{
        nixosConfigurations = {
            main-desktop = nixpkgs.lib.nixosSystem {
                inherit specialArgs system;
                modules = [
                    ./machines/desktop
                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.extraSpecialArgs = specialArgs;
                        home-manager.users."${username}" = import ./profiles/${username}.nix;
                    }
                ];
            };
        };
	};
}
