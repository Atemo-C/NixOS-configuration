{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Music player.
		audacious

		# Audio tag editor.
		easytag

		# Media control.
		playerctl
	];

}
