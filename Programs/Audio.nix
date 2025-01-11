{ pkgs, ... }: { environment = {

	# Adds MIDI soundfonts (if present) to /run/current-system/sw.
	# Why this does not seem to be done by default is beyond me.
	pathsToLink = [ "/share/soundfonts" ];

	# Audio packages to install.
	systemPackages = [
		# A lightweight and versatile audio player.
		pkgs.audacious

		# View and edit tags for various audio files.
		pkgs.easytag

		# Sound editor with graphical UI.
		pkgs.audacity

		# Audio effects for PipeWire applications.
		pkgs.unstable.easyeffects

		# Midi sound fonts.
		pkgs.soundfont-fluid
		pkgs.soundfont-arachno
		pkgs.soundfont-ydp-grand
		pkgs.soundfont-generaluser
	];

}; }
