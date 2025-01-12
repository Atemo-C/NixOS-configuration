{ pkgs, ... }: { environment.systemPackages = [

	# An open-source Nintendo DS emulator.
	pkgs.desmume

	# PlayStation 1 emulator.
	pkgs.duckstation

	# PlayStation 2 emulator.
	pkgs.pcsx2

	# PlayStation emulator.
	pkgs.rpcs3

]; }
