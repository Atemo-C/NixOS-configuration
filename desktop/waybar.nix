{ config, lib, ... }: lib.mkIf config.programs.niri.enable {
	home-manager.users.${config.userName} = rec {
		# Whether to enable the Waybar bar.
		programs.waybar.enable = true;

		# Whether to enable Waybar systemd integration; Useful for auto-starting with the desktop.
		programs.waybar.systemd.enable = lib.mkIf programs.waybar.enable true;

		# Link the configuration files for Waybar.
		systemd.user.tmpfiles.rules = lib.optionals programs.waybar.enable [
			"L %h/.config/waybar/config - - - - /etc/nixos/desktop/files/waybar/config.json"
			"L %h/.config/waybar/style.css - - - - /etc/nixos/desktop/files/waybar/style.css"
		];
	};
}