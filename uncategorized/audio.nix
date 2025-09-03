{ config, lib, pkgs, ... }: {
	services = {
		# Whether to enable the PipeWire multimedia framework.
		pipewire.enable = true;

		# Whether to enable PipeWire emulation for the ALSA audio server and its 32-bit programs.
		pipewire.alsa.enable = true;
		pipewire.alsa.support32Bit = true;

		# Whether to enable PipeWire emulation for the JACK audio server.
		pipewire.jack.enable = true;

		# Whether to enable PipeWire emulation for the PulseAudio server.
		pipewire.pulse.enable = true;

		# Whether to enable the playerctld daemon for easy multimedia control.
		playerctld.enable = true;
	};

	# Whether to enable the Realtimekit service, allowing programs like PipeWire to acquire realtime priority.
	security.rtkit.enable = true;

	environment = lib.mkIf (config.services.pipewire.enable && config.programs.niri.enable) {
		# Link installed MIDI soundfonts to `/run/current-system/sw/share/soundfonts` for easier access.
		pathsToLink = [ "/share/soundfonts" ];

		systemPackages = with pkgs; [
			audacious             # Audio player.
			easytag               # View and edit tags for various audio files.
			pwvucontrol           # Graphical volume control.
			qpwgraph              # Graph manager ("patchbay") for PipeWire.
			soundfont-arachno     # Frank Wen's pro-quality GM/GS MIDI soundfont. {Old reliable, decent, MIT.}
			soundfont-fluid       # General MIDI-compliant bank. {Awesome quality, complete, unfree.}
			soundfont-generaluser # Acoustic grand piano MIDI soundfont. {Great quality, piano-focused, CC 3.0.}
			soundfont-ydp-grand   # 259 instrument presets and 11 drum kits. {Good very quality, complete, GS 2.0.}
			tenacity              # Sound editor.
		];
	};

	# Whether to enable live audio effects using EasyEffects.
	home-manager.users.${config.userName}.services.easyeffects.enable =
	lib.mkIf (config.services.pipewire.enable && config.programs.niri.enable) true;

	# Enable Dconf for EasyEffects.
	programs.dconf.enable = lib.mkIf config.home-manager.users.${config.userName}.services.easyeffects.enable true;
}