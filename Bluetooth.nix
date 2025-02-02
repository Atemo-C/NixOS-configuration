{ config, pkgs, ... }: {

	# Bluetooth configuration tool.
	environment.systemPackages = [ pkgs.blueberry ];

	# Whether to enable support for Bluetooth.
	hardware.bluetooth.enable = true;

	# Whether to enable the Blueman Bluetooth manager.
	services.buleman.enable = true;

	# Using Bluetooth headset buttons to control media, the system way.
#	systemd.user.services.mpris-proxy = {
#		description = "Mpris proxy";
#		after = [ "network.target" "sound.target" ];
#		wantedBy = [ "default.target" ];
#		serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
#	};

	# Using Bluetooth headset buttons to control media, the Home Manager way.
	home-manager.users.users.${config.custom.name}.services.mpris-proxy.enable = true;

}
