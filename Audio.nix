{ config, lib, pkgs, ... }: let

	# Audio using PipeWire; Toggleable in this module.
	pipewire = config.services.pipewire.enable;

	# Audio effects using EasyEffects, auto-started in Hyprland.
	# • EasyEffects is Toggleable in this module.
	# • Hyprland is toggleable in the `./Hyprland/Configuration.nix` module.
	easyeffects = config.home-manager.users.${config.userName}.services.easyeffects.enable;
	hyprland = config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable;

in {

	services = {
		pipewire = {
			# Whether to enable the PipeWire multimedia framework.
			enable = true;

			# Whether to enable emulation for the ALSA audio server.
			alsa = lib.optionalAttrs pipewire {
				enable = true;
				support32Bit = true;
			};

			# Whether to enable emulation for the JACK audio server.
			jack.enable lib.optionalAttrs pipewire true;

			# Whether to enable emulation for the PulseAudio server.
			pulse.enable lib.optionalAttrs pipewire true;
		};

		# Whether to enable the playerctld daemon for easy multimedia control.
		playerctld.enable = lib.optionalAttrs pipewire true;
	};

	# Whether to enable the Realtimekit service, allowing programs like PipeWire to acquire realtime priority.
	security.rtkit.enable = lib.optionalAttrs pipewire true;

	environment = lib.optionalAttrs pipewire {
		# Link MIDI soundfonts to `/run/current-system/sw/share/soundfonts`.
		pathsToLink = [ "/share/soundfonts" ];

		# Install some audio packages.
		systemPackages = [
			# Audio player.
			pkgs.audacious
			pkgs.audacious-plugins

			# View & edit tags for various audio files.
			pkgs.easytag

			# Volume control.
			pkgs.pwvucontrol

			# Graph manager ("patchbay") for PipeWire.
			pkgs.qpwgraph

			# MIDI sound fonts.
			# Frank Wen's pro-quality GM/GS soundfont.
			# Note: Old & reliable, decent quality, MIT license.
			pkgs.soundfont-arachno

			# General MIDI-compliant bank, aimed at enhancing the realism of your MIDI files & arrangements.
			# Note: Awesome quality, quite complete, but unfree license.
			pkgs.soundfont-fluid

			# Acoustic grand piano soundfont.
			# Note: Great quality, piano-focused (obviously), CC 3.0 license.
			pkgs.soundfont-generaluser

			# SoundFont bank featuring 259 instrument presets & 11 drum kits
			# Note: Good quality, very complete, GS 2.0 license.
			pkgs.soundfont-ydp-grand

			# Sound editor.
			pkgs.tenacity
		];
	};

	home-manager.users.${config.userName} = lib.optionalAttrs pipewire {
		# Whether to enable live audio effects using EasyEffects.
		services.easyeffects.enable = true;

		# Start EasyEffects with Hyprland.
		wayland.windowManager.hyprland.settings.exec-once = lib.optionals (easyeffects && hyprland) [
			"easyeffects --gapplication-service"
		];
	};

	# Enable Dconf for EasyEffects.
	programs.dconf.enable = lib.optionalAttrs easyeffects true;

}
