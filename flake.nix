{
	description = "Luke's NixOS Flake!";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

  		home-manager = {
  			url = "github:nix-community/home-manager";
  			inputs.nixpkgs.follows = "nixpkgs";
  		};

        hyprland = {
            url = "github:hyprwm/Hyprland";
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
                        home-manager.useUserPackages = true;
                        home-manager.extraSpecialArgs = specialArgs;
                        home-manager.users."${username}" = import ./profiles/${username}.nix;
                    }
                ];
            };
        };
	};
}
