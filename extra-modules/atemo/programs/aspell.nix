{ config, lib, pkgs, ... }: let cfg = config.programs.aspell; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.aspell = {
		enable = lib.mkEnableOption ''
			Whether to enable aspell, a spell checker for many languages.
		'';

		dictionaries = lib.mkOption {
			default = [ ];
			example = lib.literalExpression " [ pkgs.aspellDicts.uk ]";
			description = "List of Aspell dictionaries to install.";
			type = lib.types.listOf lib.types.package;
		};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ pkgs.aspell ] ++ cfg.dictionaries;
	};
}