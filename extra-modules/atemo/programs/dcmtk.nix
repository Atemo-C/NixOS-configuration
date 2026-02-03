{ config, lib, pkgs, ... }: let cfg = config.programs.dcmtk; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.dcmtk.install = lib.mkEnableOption ''
		Whether to install dcmtk, a collection of libraries and applications implementing large parts of the DICOM standard.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.dcmtk;
}