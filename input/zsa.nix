{ config, lib, ... }: { programs.zsa = {
	# Graphical application for ZSA keyboards.
	keymapp.enable = lib.mkIf config.programs.niri.enable true;

	# CLI flashing utility for ZSA keyboards.
	wally-cli.enable = true;
}; }