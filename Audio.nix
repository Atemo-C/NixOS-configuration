{ config, lib, pkgs, ... }: let

	Audio = config.services.pipewire.enable;
	Effects = config.home-manager.users.${config.userName}.services.easyeffects.enable;

in {

	services = {
		pipewire = {
			# Whether to enable the PipeWire multimedia framework.
			enable = true;

			# Whether to enable emulation for the ALSA audio server.
			alsa = {
				enable = Audio;
				support32Bit = Audio;
			};

			# Whether to enable emulation for the JACK audio server.
			jack.enable = Audio;

			# Whether to enable emulation for the PulseAudio audio server.
			pulse.enable = Audio;
		};

		# Whether to enable the playerctl daemon for easy multimedia control.
		playerctld.enable = Audio;
	};

	# Whether to enable the Realtimekit service.
	# Programs such as PipeWire use it to acquire realtime priority.
	security.rtkit.enable = Audio;

	environment = {
		# Link MIDI soundfonts to `/run/current-system/sw/share/soundfonts` for easier access.
		pathsToLink = if Audio then [ "/share/soundfonts" ] else [];

		systemPackages = if Audio then [
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
		] else [];
	};

	home-manager.users.${config.userName} = {
		# Whether to enable live audio effects using EasyEffects.
		services.easyeffects.enable = true;

		# Start EasyEffect on launch if it is enabled.
		wayland.windowManager.hyprland.settings.exec-once = if Audio then [
			"easyeffects --gapplication-service"
		] else [];
	};

	# Enable Dconf if EasyEffects is enabled.
	programs.dconf.enable = lib.mkDefault Effects;

}
