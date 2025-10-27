{ ... }: { imports = [
	./programs/gnirehtet.nix
	./programs/heimdall.nix
	./programs/jmtpfs.nix
	./programs/libmtp.nix
	./programs/midiplus-smartpad-rgb-editor.nix
	./programs/rpcs3.nix
	./programs/scrcpy.nix

	./programs/zsa/keymapp.nix
	./programs/zsa/wally-cli.nix
]; }