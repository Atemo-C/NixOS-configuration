{ config, lib, ... }: {
	# Display configuration for the TTY.
	boot.kernelParams = [ "video=DP-1:1920x1080@120" ];

	# Display configuration for the Noctalia Greeter.
	services.displayManager.noctalia-greeter.settings.output = {
		name = "Acer Technologies XV242Y TL1EE0018521";
		width = 1920;
		height = 1080;
		refresh_rate = 120;
	};

	# Display configuration for the Niri Wayland compositor.
	systemd.user.tmpfiles.users.${config.user.name}.rules =
	lib.optional (config.programs.niri.enable)
	"L /etc/nixos/desktop/files/niri/output.kdl - - - - /etc/nixos/computers/r7-pc/files/output.kdl";
}