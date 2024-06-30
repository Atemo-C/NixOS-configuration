{ config, ... }: {

	home-manager.users.${config.Custom.Name}.programs.tofi = {
		# Whether to enable Tofi, a tiny dynamic menu for Wayland.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.tofi.enable
		enable = true;

		# Settings to be written to the Tofi configuration file.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.tofi.settings
		# https://github.com/philj56/tofi/blob/master/doc/config
		settings = {
			font = "/run/current-system/sw/share/X11/fonts/UbuntuMonoNerdFontRegular.ttf";
			font-size = 12;
			background-color = "#1e1e1e";
			selection-color = "#ffffff";
			selection-background = "#0f415f";
			selection-background-padding = 6;
			input-background = "#141414";
			input-background-padding = 6;
			result-spacing = 8;
			border-width = 2;
			border-color = "#0080ff";
			outline-width = 0;
		};
	};

}
