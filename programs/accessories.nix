{ config, lib, ... }: {
	programs = {
		# Mind-mapping utility.
		minder.install = false;

		# Offline password manager.
		keepassxc.install = true;
	};

	# Mind-mapping utilitiy (Flatpak install if the native package does not work properly).
	services.flatpak.packages = lib.optional (!config.programs.minder.install) "com.github.phase1geo.minder";

	# Link the calculator's .desktop file.
	systemd.user.tmpfiles.users.${config.userName}.rules = [
		"L %h/.local/share/applications/atemo-calculator.desktop - - - - /etc/nixos/files/atemo-calculator.desktop"
	];
}