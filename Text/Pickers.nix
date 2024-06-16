{ config, pkgs, ... }: {

	# Emoji picker.
	environment.systemPackages = with pkgs; [ emoji-picker ];

}
