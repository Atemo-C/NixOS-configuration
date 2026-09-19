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
	systemd.user.tmpfiles.users.${config.user.name}.rules = lib.optionals mic [
		"L %h/.config/micro/colorschemes/ - - - - /etc/nixos/programs/files/micro/colorschemes/";
		"L %h/.config/micro/plug/ - - - - /etc/nixos/programs/files/micro/plug/";
		"L %h/.config/micro/syntax/ - - - - /etc/nixos/programs/files/micro/syntax/";
		"L %h/.config/micro/bindings.json - - - - /etc/nixos/programs/files/micro/bindings.json";
		"L %h/.config/micro/init.lua - - - - /etc/nixos/programs/files/micro/init.lua";
		"L %h/.config/micro/settings.json - - - - /etc/nixos/programs/files/micro/settings.json";
	];
}
