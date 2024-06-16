{ config, pkgs, ... }: {

	# Emoji picker.
	envrionment.systemPackages = with pkgs; [ emoji-picker ];

}
