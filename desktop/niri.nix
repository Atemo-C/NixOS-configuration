{ config, lib, ... }: {
	programs = {
		niri = {
			# Whether to enable the Niri Wayland compositor.
			enable = true;

			# Whether to enable XWayland support.
			xwayland.enable = true;

			# Whether to enable Ozone Wayland support for Chromium and Electron-based programs.
			ozoneWayland.enable = true;
		};

		# Start Niri by simply typing `n` if using the FISH shell.
		fish.shellAbbrs.n = lib.mkIf (
			config.programs.fish.enable
			&& config.programs.niri.enable
		) "niri-session";
	};

	# Link Niri's configuration file.
	systemd.user.tmpfiles.users.${config.userName}.rules = lib.optional config.programs.niri.enable
	"L %h/.config/niri/config.kdl - - - - /etc/nixos/desktop/files/niri.kdl";
}