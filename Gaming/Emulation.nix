{ pkgs, ... }: { environment.systemPackages = with pkgs; [

	# An open-source Nintendo DS emulator.
	desmume

	# PlayStation 1 emulator.
	duckstation

	# PlayStation 2 emulator.
	pcsx2

	# PlayStation emulator.
	rpcs3

]; }
