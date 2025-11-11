{ ... }: { imports = [
	./programs/alsa-utils.nix
	./programs/audacious.nix
	./programs/audacity.nix
	./programs/cmd-polkit.nix
	./programs/easytag.nix
	./programs/gnirehtet.nix
	./programs/heimdall.nix
	./programs/hyprpaper.nix
	./programs/jmtpfs.nix
	./programs/libmtp.nix
	./programs/midiplus-smartpad-rgb-editor.nix
	./programs/nautilus.nix
	./programs/pwvucontrol.nix
	./programs/qpwgraph.nix
	./programs/rpcs3.nix
	./programs/scrcpy.nix
	./programs/zenity.nix

	./programs/niri/ozoneWayland.nix
	./programs/niri/xwayland.nix

	./programs/soundfont/arachno.nix
	./programs/soundfont/fluid.nix
	./programs/soundfont/generaluser.nix
	./programs/soundfont/ydp-grand.nix

	./programs/zsa/keymapp.nix
	./programs/zsa/wally-cli.nix

	./services/easyeffects.nix
]; }