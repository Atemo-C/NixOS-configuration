{ config, lib, pkgs, ... }: let
	btopPkgs = [
		pkgs.btop
		pkgs.btop-rocm
		pkgs.btom-cuda
	];

	btopPkg =
		if config.hardware.activeGpu == "amd" then pkgs.btop-rocm
		else if config.hardware.activeGpu == "nvidia-proprietary" then pkgs.btop-cuda
		else pkgs.btop;

	bto = lib.any (pkg: lib.elem pkg config.environment.systemPackages) btopPkgs;
in {
	environment.systemPackages = with pkgs; [
		# Resource monitor.
		btopPkg

		# See informatoin on the CPU, motherboard, and more.
		cpu-x

		# Fast system information tool like Neofetch.
		fastfetch

		# OpenGL and Vulkan Benchmark and Stress Test.
		furmark

		# Toolsf or reading hardware sensors.
		lm_sensors

		# Tools for monitoring the health of hard drives.
		smartmontools

		# Mersenne prime search / System stability tester (torture).
		mprime

		# Provide detailed informatoin on the hardware configuration of the machine.
		lshw

		# Vulkan tools and utilities.
		vulkan-tools

		# Collection of demos and test programs for OpenGL and Mesa.
		mesa-demos
	];

	# Small shell abbreviations to launch programs.
	programs.fish.shellAbbrs = {
		b = "${pkgs.btop}/bin/btop";
		f = "${pkgs.fastfetch}/bin/fastfetch";
	};

	# Link btop's configuration file to the user's home directory.
	systemd.user.tmpfiles.users.${config.user.name}.rules = lib.optional bto
	"L %h/.config/btop/ - - - - /etc/nixos/programs/files/btop/";
}