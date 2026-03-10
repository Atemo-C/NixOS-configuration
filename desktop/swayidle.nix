{ pkgs, ... }: { environment.systemPackages = with pkgs; [
	# Idle management daemon for Wayland.
	swayidle

	# Prevent swayidle from sleeping while any application is outputting or receiving audio.
	sway-audio-idle-inhibit
]; }