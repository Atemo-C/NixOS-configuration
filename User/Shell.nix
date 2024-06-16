{ config, pkgs, ... }: {

	# The user's shell.
	# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.shell
	users.users.username.shell = pkgs.fish;

	# Enabling the user's shell.
	# https://search.nixos.org/options?channel=24.05&show=programs.fish.enable
	programs.fish.enable = true;

}
