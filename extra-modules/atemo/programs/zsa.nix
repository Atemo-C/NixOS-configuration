{ config, lib, pkgs, ... }: let cfg = config.programs.zsa; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.zsa = {
		keymapp.enable = lib.mkEnableOption ''
			Whether to enable Keymapp, a graphical utility to flash firmware onto and interact with ZSA keyboards.
		'';

		wally-cli.enable = lib.mkEnableOption ''
			Whether to enable wally-cli, a command-line utility to flash firmware onto ZSA keyboards.
		'';
	};

	config = {
		hardware.zsa.enable = lib.mkIf (cfg.keymapp.enable || cfg.wally-cli.enable) true;

		environment.systemPackages = with pkgs; [
			(lib.optional cfg.keymapp.enable pkgs.keymapp)
			(lib.optional cfg.wally-cli.enable pkgs.wally-cli)
		];
	};
}