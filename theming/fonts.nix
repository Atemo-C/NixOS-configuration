{ config, pkgs, ... }: {
	fonts = {
		enableDefaultPackages = true;
		fontDir.enable = true;

		fontconfig = {
			cache32Bit = true;

			defaultFonts = {
				emoji = [ "Noto Color Emoji" ];
				monospace = [ "UbuntuMono Nerd Font" "Noto Color Emoji" ];
				sansSerif = [ "UbuntuSans Nerd Font" "Noto Color Emoji" ];
				serif = [ "Ubuntu Nerd Font" "Noto Color Emoji" ];
			};

			useEmbeddedBitmaps = true;
		};

		packages = with pkgs; [
			nerd-fonts.ubuntu
			nerd-fonts.ubuntu-mono
			nerd-fonts.ubuntu-sans
			noto-fonts-cjk-sans
			noto-fonts
		];
	};

	home-manager.users = {
		${config.user.name}.gtk.font = {
			name = "sans";
			size = 11;
		};

		root.gtk.font = {
			name = "sans";
			size = 11;
		};
	};

	services.kmscon.fonts = [{
		name = "UbuntuMono Nerd Font";
		package = pkgs.nerd-fonts.ubuntu-mono;
	}]
}