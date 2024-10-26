{
	description = "Luke's NixOS Flake!";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

  		home-manager = {
  			url = "github:nix-community/home-manager";
  			inputs.nixpkgs.follows = "nixpkgs";
  		};

        hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

        sddm-sugar-candy-nix = {
            url = "github:Zhaith-Izaliel/sddm-sugar-candy-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        
        community-emacs.url = "github:nix-community/emacs-overlay";
	};

	outputs = { ... }@inputs:
	let
        # Thanks vimjoyer for the resources !
        my_lib = import ./lib/helpers.nix { inherit inputs; };
	in
    with my_lib;
	{
		nixosConfigurations = {
            mainNixOS = mkSystem ./nixos/main_configuration.nix;
		};

        homeConfigurations = {
            "lukeolson@nixon" = mkHome "x86_64-linux" ./modules/home.nix;
        };
	};
}
