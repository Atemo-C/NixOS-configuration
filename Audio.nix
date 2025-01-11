{ config, pkgs, ... }: {

	# Packages for controlling general audio settings, as well as various audio utilities.
	# More specific audio tools (music player, sound effects, etc) can be found in Programs/Audio.nix.
	environment.systemPackages = [
		# Utilities for ALSA.
		pkgs.alsa-utils

		# Graphical volume control.
		pkgs.unstable.pavucontrol

		# PipeWire patchbay.
		pkgs.qpwgraph
	];

	services = {
		# PipeWire multimedia framework.
		pipewire = {
			alsa = {
				# Whether to enable ALSA support.
				enable = true;

				# Whether to enable 32-bit ALSA support.
				support32Bit = true;
			};

			# Whether to enable PipeWire.
			enable = true;

			# Whether to enable JACK support.
			jack.enable = true;

			# Whether to enable PulseAudio support.
			pulse.enable = true;

			# Which PipeWire package to use.
			package = pkgs.unstable.pipewire;

			# The WirePlumber package to use.
			# It should be from the same branch as PipeWire.
			wireplumber.package = pkgs.unstable.wireplumber;
		};

		# Whether to enable the playerctl daemon.
		# Not needed / Already enabled on some desktops.
		playerctld.enable = true;
	};

}
