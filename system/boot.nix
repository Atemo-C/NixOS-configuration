{ config, lib, pkgs, ... }: { boot = {
	# Linux Kernel package to use.
	kernelPackages = pkgs.linuxPackages_zen;

	loader = {
		limine = {
			# whether to enable te Limine bootloader.
			enable = true;

			# Maximum number of latest generations to keep in the boot menu.
			maxGenerations = 64;

			style = {
				# Background color.
				backdrop = "000000";

				# Wallpapers to use.
				wallpapers = lib.mkForce [];

				# Style of wallpaper (if one is used).
				wallpaperStyle = "centered";

				# Branding.
				interface.branding = "Atemo's NixOS configuration for ${config.user.name} on ${config.networking.hostName}";
			};
		};

		# Timeout in seconds until the bootloader starts the default menu item.
		timeout = 1;
	};

	plymouth = {
		# Whether to enable the Plymouth boot splash screen.
		enable = true;

		# Plymouth theme to use.
		theme = "colorful_sliced";

		# Package providing the Plymouth theme.
		themePackages = [ (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "colorful_sliced" ]; }) ];
	};

	# The kernel console `loglevel`.
	#consoleLogLevel = 3;
	consoleLogLevel = 0;

	# Whether the initrd should be verbose.
	initrd.verbose = false;

	kernelParams = [
		# Make booting less verbose/more quiet.
		"quiet"
		"udev.log_level=3"
		"systemd.show_status=auto"

		# Use full preemption to help performances for certain use cases.
		"preempt=full"
	];
}; }