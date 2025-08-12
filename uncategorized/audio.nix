{ config, lib, pkgs, ... }: {
	services = {
		pipewire = {
			# Whether to enable the PipeWire multimedia framework.
			enable = true;

			alsa = lib.mkIf config.services.pipewire.enable rec {
				# Whether to enable emulation for the ALSA audio server.
				enable = true;

				# Whether to also enable support for 32-bit programs.
				support32Bit = lib.mkIf enable true;
			};

			# Whether to enable emulation for the JACK audio server.
			jack.enable = lib.mkIf config.services.pipewire.enable true;

			# Whether to enable emulation for the PulseAudio server.
			pulse.enable = lib.mkIf config.services.pipewire.enable true;
		};

		# Whether to enable the playerctld daemon for easy multimedia control.
		playerctld.enable = lib.mkIf config.services.pipewire.enable true;
	};

	# Whether to enable the Realtimekit service.
	# It allows programs like PipeWire to acquire realtime priority.
	security.rtkit.enable = lib.mkIf config.services.pipewire.enable true;

	environment = lib.mkIf (config.services.pipewire.enable && config.programs.niri.enable) {
		# Link installed MIDI soundfonts to `/run/current-system/sw/share/soundfonts` for easier access.
		pathsToLink = [ "/share/soundfonts" ];

		systemPackages = with pkgs; [
			# Audio player.
			audacious
			audacious-plugins

			# View and edit tags for various audio files.
			easytag

			# Graphical volume control.
			pwvucontrol

			# Graph manager ("patchbay") for PipeWire.
			qpwgraph

			# Frank Wen's pro-quality GM/GS MIDI soundfont.
			# Note: Old and reliable, decent quality, MIT license.
			#soundfont-arachno

			# General MIDI-compliant bank, aimed at enhancing the realism of your MIDI files and arrangements.
			# Note: Awesome quality, very complete, but unfree license.
			soundfont-fluid

			# Acoustic grand piano MIDI soundfont.
			# Note: Great quality, piano-focused (obviously), CC 3.0 license.
			#soundfont-generaluser

			# MIDI soundFont bank featuring 259 instrument presets and 11 drum kits.
			# Note: Good quality, very complete, GS 2.0 license.
			#soundfont-ydp-grand

			# Sound editor.
			tenacity
		];
	};

	# Whether to enable live audio effects using EasyEffects.
	home-manager.users.${config.userName}.services.easyeffects.enable =
	lib.mkIf (config.services.pipewire.enable && config.programs.niri.enable) true;

	# Enable Dconf for EasyEffects.
	programs.dconf.enable = lib.mkIf config.home-manager.users.${config.userName}.services.easyeffects.enable true;
}