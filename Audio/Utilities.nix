{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Audio tools.
		alsa-utils

		# Audio effects.
		easyeffects

		# Audio control.
		pavucontrol

		# Audio/Video patchbay.
		qpwgraph
	];

}
