{ inputs, lib, user, pkgs, ... }:

{
	imports = [ 
        # Include the results of the hardware scan.
		./desktop-hardware.nix
        inputs.sddm-sugar-candy-nix.nixosModules.default
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
        grub.extraEntries = ''
            menuentry "Reboot" {
                reboot
            }
            menuentry "Power Off" {
                halt
            }
        '';
    };

    boot.initrd = {
        kernelModules = [ "amdgpu" ];
    };

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

	# Lets use some flakes baybee
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Only keep a week's worth of generations
	nix.settings.auto-optimise-store = true;

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

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

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
    };

    services.blueman = {
        enable = true;
    };

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };

	fonts = {
		enableDefaultPackages = true;
		packages = with pkgs; [
			iosevka
			(nerdfonts.override { fonts = [ "Iosevka" ]; })	
            jetbrains-mono
		];

		fontconfig = {
			defaultFonts = {
				# monospace = [ "Iosevka Mono" ];
				monospace = [ "JetBrains Mono" ];
			};
		};
	};

    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;

    environment = {
        variables = {
            EDITOR = "nvim";
            VISUAL = "nvim";
            TERM = "alacritty";
            SHELL = "zsh";
            XDG_CURRENT_DESKTOP = "Hyprland";
            XDG_SESSION_TYPE = "wayland";
            XDG_SESSION_DESKTOP = "Hyprland";
        };
        # these may work?
        sessionVariables = {
            MOZ_ENABLE_WAYLAND = "1";
            NIXOS_OZONE_WL = "1";
            T_QPA_PLATFORM = "wayland";
            GDK_BACKEND = "wayland";
            WLR_NO_HARDWARE_CURSORS = "1";
        };
    };
}
