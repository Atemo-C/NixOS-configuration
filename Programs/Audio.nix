{ config, pkgs, ... }: {

	environment = {
		# Adds MIDI soundfonts (if present) to /run/current-system/sw.
		# Why this does not seem to be done by default is beyond me.
		pathsToLink = [ "/share/soundfonts" ];

		# Audio packages to install.
		systemPackages = with pkgs; [
			# A lightweight and versatile audio player.
			audacious

			# View and edit tags for various audio files.
			easytag

			# Sound editor with graphical UI.
			tenacity

			# Midi sound fonts.
			soundfont-fluid
			soundfont-arachno
			soundfont-ydp-grand
			soundfont-generaluser
		];
	};

	# Audio effects for PipeWire applications.
	home-manager.users.${config.custom.name}.services.easyeffects = {
		# Whether to enable EasyEffects.
		# Necessitates programs.dconf.enable to be true.
		enable = true;
	};

}
