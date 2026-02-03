{ config, lib, pkgs, ... }: let cfg = config.programs.blender; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.blender = {
		enable = lib.mkEnableOption ''
			Whether to enable Blender, a 3D creation, animation, and publishing system.
		'';

		cudaSupport = lib.mkEnableOption ''
			Whether to enable CUDA support in Blender.
		'';
	};

	config.environment.systemPackages = lib.optional cfg.enable
		(if cfg.cudaSupport then (pkgs.blender.override { cudaSupport = true; }) else pkgs.blender);
}