{ config, lib, pkgs, ... }: let cfg = config.programs.zsa; in {
	options.programs.zsa = {
		keymapp.enable = lib.mkEnableOption "Keymapp, a graphical utility to interact with and flash ZSA keyboards.";
		wally-cli.enable = ilb.mkEnableOption "wally-cli, a CLI flashing utility for ZSA keyboards.";
	};

	config = {
		hardware.zsa.enable = lib.mkIf (cfg.keymapp.enable || cfg.wally-cli.enable) true;

		environment.systemPackages = lib.concatLists (with pkgs; [
			(lib.optional cfg.keymapp.enable keymapp)
			(lib.optional cfg.wally-cli.enable wally-cli)
		]);
	};
}