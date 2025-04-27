{ config, lib, pkgs, ... }: rec {

	# Audio & media-related services configuration.
	services = {
		pipewire = {
			# Enable the PipeWire multimedia framework.
			enable = true;

			# Optionally, add support to emulate other audio servers, for compatibility.
			# (ALSA, JACK, and PulseAudio)
#			alsa = {
#				enable = true;
#				support32Bit = true;
#			};
#			jack.enable = true;
#			pulse.enable = true;
		};

		# Enable the playerctld daemon for easy multimedia control.
		playerctld.enable = services.pipewire.enable;
	};

	# Enable the RealtimeKit service to allow PipeWire to acquire realtime priority.
	security.rtkit.enable = services.pipewire.enable;

	environment = {
		# Link MIDI soundfonts to `/run/current-system/sw/share/soundfonts` to make their access easier.
		pathsToLink = [ "/share/soundfonts" ];

		systemPackages = [
			# Lightweight and versatile audio player.
			pkgs.audacious pkgs.audacious-plugins

			# View and edit tags for various audio files.
			pkgs.easytag

			# PipeWire volume control.
			(if services.pipewire.enable then pkgs.pwvucontrol else null)

			# Qt graph manager (patchbay) for PipeWire.
			(if services.pipewire.enable then pkgs.qpwgraph else null)

			# MIDI sound fonts.
			pkgs.soundfont-fluid
			pkgs.soundfont-arachno
			pkgs.soundfont-ydp-grand
			pkgs.soundfont-generaluser

			# Sound editor.
			pkgs.tenacity
		];
	};

	home-manager.users.${config.userName} = rec {
		# Enable live audio effects using EasyEffects. Dconf will be enabled automatically as it is needed.
		services.easyeffects.enable = true;

		# Auto-start EasyEffects if it is enabled.
		wayland.windowManager.hyprland.settings.exec-once = [
			(if services.easyeffects.enable then "easyeffects --gapplication-service" else null)
		];
	};

	# Enable Dconf if EasyEffects is enabled.
	programs.dconf.enable = lib.mkDefault services.easyeffects.enable;

}
