{ config, lib, pkgs, ... }: let cfg = config.programs.hunspell; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.hunspell = {
		enable = lib.mkEnableOption ''
			Whether to enable hunspell, a spell checker.
		'';

		dictionaries = lib.mkOption {
			default = [ ];
			example = lib.literalExpression " [ pkgs.hunspellDicts.en_US ]";
			description = "List of Hunspell dictionaries to install.";
			type = lib.types.listOf lib.types.package;
		};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ pkgs.hunspell ] ++ cfg.dictionaries;
	};
}