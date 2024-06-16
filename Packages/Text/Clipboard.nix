{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [

		# Clipboard manager.
		clipman

		# Clipboard for Wayland.
		wl-clipboard
	];

}
