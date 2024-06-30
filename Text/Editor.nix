{ config, pkgs, ... }: {

	environment = {
		# Set Micro as the default text editor.
		variables = { EDITOR = "micro"; };
	};

	home-manager.users.${config.Custom.Name}.programs.micro = {
		# Whether to enable micro, a terminal-based text editor.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.micro.enable
		enable = true;

		# Configuration written to $XDG_CONFIG_HOME/micro/settings.json.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.micro.settings
		# https://github.com/zyedidia/micro/blob/master/runtime/help/options.md
		settings = {
			"*.conf" = { filetype = "shell"; };
			"*.dirs" = { filetype = "shell"; };
			"*.jsonc" = { filetype = "json"; };
			"*.sav" = { filetype = "nix"; };
			colorcolumn = 120;
			colorscheme = "Atemos-colours";
			relativeruler = true;
			rmtrailingws = true;
			softwrap = true;
			tabhighlight = true;
			wordwrap = true;
		};
	};

	# Disabling the nano text editor enabled by default.
	# https://search.nixos.org/options?channel=24.05&show=programs.nano.enable
	programs.nano.enable = false;

}
