{ config, pkgs, ... }: {

	environment = {
		# Link MIDI sound fonts (if present) to `/run/current-system/sw/share/soundfonts`.
		pathsToLink = [ "/share/soundfonts" ];

		# Packages for controlling general audio settings, as well as some audio utilities, such as a music player.
		systemPackages = [
			# Utilitties for ALSA.
			pkgs.alsa-utils

			# A lightweight and versatile audio player.
			pkgs.audacious pkgs.audacious-plugins

			# View and edit tags for various audio files.
			pkgs.easytag

			# Graphical volume control.
			pkgs.pavucontrol

			# PipeWire patchbay.
			pkgs.qpwgraph

			# MIDI sound fonts.
			pkgs.soundfont-fluid
			pkgs.soundfont-arachno
			pkgs.soundfont-ydp-grand
			pkgs.soundfont-generaluser

			# Graphical sound editor.
			pkgs.tenacity
		];
	};

	home-manager.users.${config.userName} = rec {
		# Whether to enable audio effects using EasyEffects.
		# Necessitates `programs.dconf.enable` to be `true`.
		services.easyeffects.enable = true;

		# If `services.easyeffects.enable` is `true`, add it to startup programs in the Hyprland Wayland compositor.
		wayland.windowManager.hyprland.settings.exec-once = [
			( if services.easyeffects.enable then "easyeffects --gapplication-service" else null )
		];
	};

	# Whether to enable the RealtimeKit system service.
	# It hands out realtime scheduling priority to user processes on demand.
	# PipeWire uses this to acquire realtime priority.
	security.rtkit.enable = true;

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
		};

		# Whether to enable the playerctl daemon.
		# Some desktop environments provide it out of the box.
		playerctld.enable = true;
	};

}
