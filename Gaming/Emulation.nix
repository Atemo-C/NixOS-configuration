{ pkgs, ... }: { environment.systemPackages = [

	# An open-source Nintendo DS emulator.
	pkgs.desmume

	# PlayStation 1 emulator.
	pkgs.unstable.duckstation

	# PlayStation 2 emulator.
	pkgs.unstable.pcsx2

	# PlayStation emulator.
	pkgs.unstable.rpcs3

]; }
