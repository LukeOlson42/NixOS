{
	description = "NixOS Flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
  		home-manager = {
  			url = "github:nix-community/home-manager";
  			inputs.nixpkgs.follows = "nixpkgs";
  		};
        hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
	};

	outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs:
	let
		system = "x86_64-linux";
		pkgs = import nixpkgs {
			inherit system;
			config = {
				allowUnfree = true;
			};
		};
	in
	{
		nixosConfigurations = {
			# We can build configurations for different machines!
			mainNixOS = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs system; };
				modules = [
					./nixos/main_configuration.nix
					home-manager.nixosModules.default
				];
			};

			# For CLI-only NixOS configuration
			# workNixOS = nixpkgs.lib.nixosSystem {
			# 	specialArgs = { inherit inputs system; };
			# 	modules = [
			# 		./nixos/work_configuration.nix
			# 		home-manager.nixosModules.default
			# 	];
			# };

			# For CLI-only NixOS configuration
			# cliNixOS = nixpkgs.lib.nixosSystem {
			# 	specialArgs = { inherit inputs system; };
			# 	modules = [
			# 		./nixos/cli_configuration.nix
			# 		home-manager.nixosModules.default
			# 	];
			# };
		};
	};
}
