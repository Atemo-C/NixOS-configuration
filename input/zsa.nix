{ config, lib, ... }: { programs = {
	# Whether to enable Keymapp, a graphical application for ZSA keyboards.
	zsa.keymapp.enable = lib.mkIf config.programs.niri.enable true;

	# Whether to enable wally-cli, a CLI flashing utility for ZSA keyboards.
	zsa.wally-cli.enable = true;
}; }