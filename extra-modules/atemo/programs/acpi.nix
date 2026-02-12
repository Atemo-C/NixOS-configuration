{ config, lib, pkgs, ... }: let cfg = config.programs.acpi; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.acpi.install = lib.mkEnableOption ''
		Whether to install acpi, a tool to show battery status and other ACPI information.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.acpi;
}