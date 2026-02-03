{ config, lib, pkgs, ... }: let cfg = config.programs.gstreamer; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.gstreamer = {
		enable = lib.mkEnableOption ''
			Whether to enable Gstreamer, an open source multimedia framework.
		'';

		plugins = lib.mkOption {
			default = [ ];
			example = lib.literalExpression "[ pkgs.gst_all_1.gst-plugins-base ]";
			description = "List of Gstreamer plugins to install.";
			type = lib.types.listOf lib.types.package;
		};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ pkgs.gst_all_1.gstreamer cfg.plugins ];
	};
}