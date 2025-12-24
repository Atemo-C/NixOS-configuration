{ config, lib, ... }: {
	programs = {
		niri = {
			# Whether to enable the Niri Wayland compositor
			enable = true;

			# Whether to enable XWayland support with xwayland-satellite.
			xwayland.enable = true;

			# Whether to enable Ozone Wayland support for Chromium/Electron-based programs.
			ozoneWayland.enable = true;
		};

		# Start Niri by typing `n` from a console.
		fish.shellAbbrs.n = lib.mkIf config.programs.niri.enable "niri-session";
	};

	# Link Niri's configuration file.
	systemd.user.tmpfiles.users.${config.userName}.rules = lib.optional config.programs.niri.enable
	"L %h/.config/niri/config.kdl - - - - /etc/nixos/niri/files/niri.kdl";
}