{ config, lib, pkgs, ... }: let cfg = config.programs.cuda; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.cuda = {
		cudnn.install = lib.mkEnableOption ''
			Whether to install cudnn, a GPU-accelerated library of primitives for deep neural networks.
		'';

		cudatoolkit.install = lib.mkEnableOption ''
			Whether to install cudatoolkit, a wrapper substituting the deprecated runfile-based CUDA installation.
		'';

		libcutensor.install = lib.mkEnableOption ''
			Whether to install libcutensor, a GPU-accelerated tensor linear algebra library for tensor contraction, reduction, and elementwise operations.
		'';
	};

	config.environment.systemPackages = [
		(lib.optional cfg.cudnn.install pkgs.cudnn)
		(lib.optional cfg.cudatoolkit.install pkgs.cudatoolkit)
		(lib.optional cfg.libcutensor.install pkgs.libcutensor)
	];
}