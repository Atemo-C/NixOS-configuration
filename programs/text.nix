{ config, lib, pkgs, ... }: let
	microPkgs = [
		pkgs.micro
		pkgs.micro-full
		pkgs.micro-with-wl-clipboard
		pkgs.micro-with-xclip
	];
	mic = lib.any (pkg: lib.elem pkg config.environment.systemPackages) microPkgs;
in {
	environment = {
		systemPackages = with pkgs; [
			# Aspell spell checking.
			aspell

			# GNOME Character Map, based on the Unicode Character Database.
			gucharmap

			# Hunspell spell checking.
			hunspell

			# Modern and intuitive terminal-based text editor.
			micro
		];

		# Set the default text editor.
		variables.EDITOR = lib.mkIf mic "micro";
	};

	# Shell abbreviation to launch the text editor.
	programs.fish.shellAbbrs.m = lib.mkIf mic "micro";

	# Link Micro's configuration files to the user's home directory.
	systemd.user.tmpfiles.users.${config.user.name}.rules = lib.optional mic
	"L %h/.config/micro/ - - - - /etc/nixos/programs/files/micro/";
}
