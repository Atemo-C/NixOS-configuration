{ config, lib, pkgs, ... }: let cfg = config.programs.ferium; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.ferium.install = lib.mkEnableOption ''
		Whether to install Ferium, a fast and multi-source CLI program for managing Minecraft mods and modpacks from Modrinth, CurseForge, and GitHub Releases.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.ferium;
}