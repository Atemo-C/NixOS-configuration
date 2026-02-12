{ config, lib, pkgs, ... }: let cfg = config.programs.mpv; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.mpv = {
		enable = lib.mkEnableOption ''
			Whether to enable mpv, a general-purpose media player, fork of MPlayer and mplayer2.
		'';

		package = lib.mkPackageOption pkgs "mpv" {
			default = [ "mpv" ];
			example = [ "mpv-unwrapped" ];
		};

		plugins = lib.mkOption {
			default = [ ];
			example = lib.literalExpression "[ pkgs.mpvScripts.mpris ]";
			description = "List of mpv plugins to install.";
			type = lib.types.listOf lib.types.package;
		};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = lib.optional (cfg.package != null) (cfg.package.override {
			scripts = cfg.plugins;
		});

		assertions = lib.singleton {
			assertion = cfg.package == null -> cfg.plugins == [ ];
			message = "Plugins cannot be set if package is null.";
		};
	};
}