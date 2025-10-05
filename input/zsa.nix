{ config, ... }: { programs = {
	# Whether to enable Keymapp, a graphical application for ZSA keyboards.
	keymapp.enable = lib.mkIf config.programs.niri.enable true;

	# Whether to enable wally-cli, a CLI flashing utility for ZSA keyboards.
	wally-cli.enable = true;
}; }