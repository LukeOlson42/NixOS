# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
	imports =
	[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		inputs.home-manager.nixosModules.home-manager
	];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixon"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "America/New_York";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.lukeolson = {
		isNormalUser = true;
		description = "Luke Olson";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [];
	};

	# Lets use some flakes baybee
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Only keep a month's worth of generations
	nix.settings.auto-optimise-store = true;
	nix.gc.automatic = true;
	nix.gc.dates = "daily";
	nix.gc.options = "--delete-older-than 15d";

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# Split in multiple files, for different package lists
	environment.systemPackages = with pkgs; [
		firefox
		home-manager
	];

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

    services.xserver.enable = true;
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
    };

    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;

    hardware.graphics.enable = true;


	# Home Manager
	home-manager = {
        extraSpecialArgs = { inherit inputs; };
        users = {
            lukeolson = import ./../modules/home.nix;
        };
	};

	# Set font to Iosevka (or whatever I end up doing)
	fonts = {
		enableDefaultPackages = true;
		packages = with pkgs; [
			iosevka
			(nerdfonts.override { fonts = [ "Iosevka" ]; })	
		];

		fontconfig = {
			defaultFonts = {
				monospace = [ "Iosevka Mono" ];
			};
		};
	};

	environment.variables = {
		EDITOR = "nvim";
		VISUAL = "nvim";
		TERM = "alacritty";
		SHELL = "zsh";
	};

	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	# services.openssh.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.05"; # Did you read the comment?

}
