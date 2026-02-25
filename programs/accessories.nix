{ config, ... }: {
	programs = {
		# Mind-mapping utility.
		minder.install = false;

		# Offline password manager.
		keepassxc.install = true;
	};

	# Link the calculator's .desktop file.
	systemd.user.tmpfiles.users.${config.userName}.rules = [
		"L %h/.local/share/applications/atemo-calculator.desktop - - - - /etc/nixos/files/atemo-calculator.desktop"
	];
}