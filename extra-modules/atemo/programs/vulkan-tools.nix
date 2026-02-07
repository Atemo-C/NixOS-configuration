{ config, lib, pkgs, ... }: let cfg = config.programs.vulkan-tools; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.vulkan-tools.install = lib.mkEnableOption ''
		Whether to install Vulkan Tools, Khronos official Vulkan Tools and Utilities.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.vulkan-tools;
}