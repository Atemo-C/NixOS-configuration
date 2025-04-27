{ config, lib, pkgs, ... }: rec {

	# Audio & media-related services configuration.
	services = {
		# PipeWire multimedia framework.
		pipewire = {
			# Whether to enable PipeWire.
			enable = true;

			# ALSA emulation under PipeWire.
			alsa = {
				# Whether to enable ALSA support.
				enable = true;

				# Whether to enable 32-bit ALSA support.
				support32Bit = true;
			};

			# Whether to enable support for JACK audio emulation support.
			jack.enable = true;

			# Whether to enable PulseAudio audio emulation support.
			pulse.enable = true;
		};

		# Whether to enable the playerctld daemon for easy multimedia control.
		playerctld.enable = services.pipewire.enable;
	};

	# Whether to enable the RealtimeKit system service.
	# It hands out realtime scheduling priority to user processes on demand.
	# PipeWire uses this to acquire realtime priority.
	security.rtkit.enable = services.pipewire.enable;

	environment = {
		# Link MIDI soundfonts to `/run/current-system/sw/share/soundfonts` to make them easily accessible.
		pathsToLink = [ "/share/soundfonts" ];

		# Audio-related packages.
		systemPackages = [
			# Utilities for ALSA, the Advanced Linux Sound Architecture utils.
			(if services.pipewire.alsa.enable then pkgs.alsa-utils else null)

			# Lightweight and versatile audio player & useful plugins.
			pkgs.audacious
			pkgs.audacious-plugins

			# View and edit tags for various audio files.
			pkgs.easytag

			# Graphical volume control.
			(if services.pipewire.enable then pkgs.pavucontrol else null)

			# Qt graph manager for PipeWire, similar to QjackCtl.
			(if services.pipewire.enable then pkgs.qpwgraph else null)

			# MIDI sound fonts.
			pkgs.soundfont-fluid
			pkgs.soundfont-arachno
			pkgs.soundfont-ydp-grand
			pkgs.soundfont-generaluser

			# Sound editor with graphical UI.
			pkgs.tenacity
		];
	};

	home-manager.users.${config.userName} = rec {
		# Whether to enable audio effects for PipeWire applications using EasyEffects.
		# It necessitates Dconf to be enabled.
		services.easyeffects.enable = true;

		# Enable Dconf if EasyEffects is enabled.
		programs.dconf.enable = lib.mkDefault services.easyeffects.enable;

		# If EasyEffects is enabled, it is added to startup programs in the Hyprland Wayland compositor.
		wayland.windowManager.hyprland.settings.exec-once = [
			(if services.easyeffects.enable then "easyeffects --gapplication-service" else null)
		];
	};

}
