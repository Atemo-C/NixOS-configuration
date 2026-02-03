{ config, lib, pkgs, ... }: let cfg = config.programs.prismlauncher; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.prismlauncher.install = lib.mkEnableOption ''
		Whether to install PrismLauncher, a free, open source launcher for Minecraft.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.prismlauncher;
}