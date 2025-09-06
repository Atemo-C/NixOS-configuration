{ config, lib, ... }: lib.mkIf config.programs.niri.enable { home-manager.users.${config.userName} = {
	# Whether to enable the Waybar bar.
	programs.waybar.enable = true;

	# Whetehr to enable Waybar systemd integration; Useful for auto-starting with the desktop.
	programs.waybar.systemd.enable = true;

	# Link the configuration files for Waybar.
	systemd.user.tmpfiles.rules = lib.optionals config.home-manager.users.${config.userName}.programs.waybar.enable [
		"L %h/.config/waybar/config - - - - /etc/nixos/desktop/files/waybar/config.json"
		"L %h/.config/waybar/style.css - - - - /etc/nixos/desktop/files/waybar/style.css"
	];
}; }