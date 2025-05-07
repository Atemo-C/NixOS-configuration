{ config, pkgs, ... }: let

	pipewire    = config.services.pipewire.enable;
	easyeffects = config.home-manager.users.${config.userName}.services.easyeffects.enable;
	hyprland    = config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable;

in {

	services = {
		pipewire = {
			# Whether to enable the PipeWire multimedia framework.
			enable = true;

			# If PipeWire is enabled, enable emulation for the ALSA audio server.
			alsa = {
				enable = pipewire;
				support32Bit = pipewire;
			};

			# If PipeWire is enabled, enable emulation for the JACK audio server.
			jack.enable = pipewire;

			# If PipeWire is enabled, enable emulation for the PulseAudio audio server.
			pulse.enable = pipewire;
		};

		# If PipeWire is enabled, enable the playerctld daemon for easy multimedia control.
		playerctld.enable = pipewire;
	};

	# If PipeWire is enabled, enable the Realtimekit service.
	# It allows programs such as PipeWire to acquire realtime priority.
	security.rtkit.enable = pipewire;

	environment = if pipewire then {
		# Link MIDI soundfonts to `/run/current-system/sw/share/soundfonts` for easier access.
		pathsToLink = [ "/share/soundfonts" ];

		# Install some audio utilities.
		systemPackages = [
			# View and edit tags for various audio files.
			pkgs.audacious pkgs.audacious-plugins

			# View and edit tags for various audio files.
			pkgs.easytag

			# PipeWire volume control.
			pkgs.pwvucontrol

			# QT graph manager (patchbay) for PipeWire.
			pkgs.qpwgraph

			# MIDI sound fonts.
			pkgs.soundfont-arachno
			pkgs.soundfont-fluid
			pkgs.soundfont-generaluser
			pkgs.soundfont-ydp-grand

			# Sound editor.
			pkgs.tenacity
		];
	} else {};

	home-manager.users.${config.userName} = {
		# Whether to enable live audio effects using EasyEffects.
		services.easyeffects.enable = true;

		# If EasyEffect is enabled, start it on launch.
		wayland.windowManager.hyprland.settings.exec-once = if pipewire && hyprland then [
			"easyeffects --gapplication-service"
		] else [];
	};

	# If EasyEffect is enabled, enable Dconf, which EasyEffects needs.
	programs.dconf.enable = easyeffects;

}
