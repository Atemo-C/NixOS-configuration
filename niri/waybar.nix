{ config, lib, ... }: lib.mkIf config.programs.niri.enable {
	home-manager.users.${config.userName}.programs.waybar = {
		# Whether to enable the Waybar bar.
		enable = true;

		# Whether to enable Waybar systemd integration.
		# This allows it to automatically start with the desktop.
		systemd.enable = true;
	};

	# Link Waybar's configuration files.
	systemd.user.tmpfiles.users.${config.userName}.rules = lib.optionals
	config.home-manager.users.${config.userName}.programs.waybar.enable [
		"L %h/.config/waybar/config - - - - /etc/nixos/niri/files/waybar/config.json"
		"L %h/.config/waybar/style.css - - - - /etc/nixos/niri/files/waybar/style.css"
	];
}