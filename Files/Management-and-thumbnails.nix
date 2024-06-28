{ config, pkgs, ... }: {

	programs.thunar = {
		# Whether to enable XFCE's file manager, Thunar.
		# https://search.nixos.org/options?channel=24.05&show=programs.thunar.enable
		enable = true;

		# List of Thunar plugins to install.
		# https://search.nixos.org/options?channel=24.05&show=programs.thunar.plugins
		plugins = with pkgs.xfce; [
			thunar-archive-plugin
			thunar-volman
			thunar-media-tags-plugin
		];
	};

	environment.systemPackages = with pkgs; [
		# Thumbnailing utilities and formats.
		ffmpegthumbnailer
		webp-pixbuf-loader
		poppler
		freetype
		libgsf
		nufraw-thumbnailer
		gnome-epub-thumbnailer
		kdePackages.kimageformats
		kdePackages.qtsvg

		# XFCE's exo tool.
		xfce.exo
	];

	services = {
		# Whether to enable GVfs.
		# https://search.nixos.org/options?channel=unstable&show=services.gvfs.enable
		gvfs.enable = true;

		# Whether to enable the Tumbler D-Bus thumbnailer service.
		# https://search.nixos.org/options?channel=24.05&show=services.tumbler.enable
		tumbler.enable = true;
	};

}
