{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Nintendo DS emulator.
		desmume

		# Playstation 2 emulator.
		unstable.pcsx2

		# Playstation 3 emulator.
		unstable.rpcs3
	];

}
