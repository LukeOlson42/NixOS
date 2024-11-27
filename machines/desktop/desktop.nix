# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, ... }:

{
	imports = [ 
        # Include the results of the hardware scan.
		./desktop-hardware.nix

        # Kinda hacky but it works
		inputs.home-manager.nixosModules.home-manager

        ../../components/gaming/gaming.nix
	];

	# Bootloader
    boot.loader = {
        systemd-boot.enable = false;
        grub = {
            enable = true;
            device = "nodev";
            useOSProber = true;
            efiSupport = true;
        };
        efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot";
        };
    };

    boot.initrd = {
        kernelModules = [ "amdgpu" ];
    };

	# Enable networking
    networking.hostName = "nixos-desktop"; # Define your hostname.
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
		packages = with pkgs; [
            qalculate-qt
        ];
	};

	# Lets use some flakes baybee
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Only keep a week's worth of generations
	nix.settings.auto-optimise-store = true;
	nix.gc.automatic = true;
	nix.gc.dates = "daily";
	nix.gc.options = "--delete-older-than 21d";

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# Split in multiple files, for different package lists
	environment.systemPackages = with pkgs; [
		firefox
		home-manager
        linux-manual
        man-pages
        man-pages-posix
	];

    services.xserver = {
        enable = true;
        videoDrivers = [ "amdgpu" ];
    };
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        autoNumlock = true;

        sugarCandyNix = {
            enable = true;
            settings = {
                Background   = lib.cleanSource ../../wallpapers/halfdome.jpg;
                ScreenWidth  = 1920;
                ScreenHeight = 1080;
                FormPosition = "left";
                HaveFormBackground = true;
                PartialBlur = true;
            };
        };
    };

    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };

	# Home Manager
	home-manager = {
        extraSpecialArgs = { inherit inputs; };
        users = {
            lukeolson = import ./../../profiles/lukeolson.nix;
        };
	};

	# Set font to Iosevka
	fonts = {
		enableDefaultPackages = true;
		packages = with pkgs; [
			iosevka
			(nerdfonts.override { fonts = [ "Iosevka" ]; })	
            jetbrains-mono
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

	system.stateVersion = "24.05"; 
}
