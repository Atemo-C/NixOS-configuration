{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Mersenne prime search / System stability tester (torture).
		mprime

		# Vulkan tools and utilties.
		vulkan-tools

		# Collection of demos and test programs for OpenGL and Mesa.
		mesa-demos

		# Like Neofetch, but written in C and actually maintained.
		fastfetch

		# Provide detailed information on the hardware configuration of the machine.
		lshw
#		lshw-gui
	];

}
