{ config, lib, pkgs, ... }: {
	home-manager.users.${config.userName} = lib.mkIf config.programs.niri.enable rec {
		programs.waybar = {
			# Whether to enable the Waybar bar.
			enable = true;

			# Whether to enable Waybar systemd integration; Useful for things like auto-starting itself.
			systemd.enable = lib.mkIf programs.waybar.enable true;
		};

		# Link the configuration file to the right place.
		systemd.user.tmpfiles.rules = lib.optionals programs.waybar.enable [
			"L %h/.config/waybar/config - - - - /etc/nixos/desktop/files/waybar/config.json"
			"L %h/.config/waybar/style.css - - - - /etc/nixos/desktop/files/waybar/style.css"
		];
	};
}