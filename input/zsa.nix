{ ... }: { programs.zsa = {
	# Graphical application for ZSA keyboards.
	keymapp.enable = true;

	# CLI flashing utility for ZSA keyboards.
	wally-cli.enable = true;
}; }