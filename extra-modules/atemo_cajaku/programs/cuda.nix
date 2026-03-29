{ config, lib, pkgs, ... }: let cfg = config.programs.cuda; in {
	options.programs.cuda = {
		cudatoolkit.enable = lib.mkEnableOption "cudatoolkit, a wrapper substituting the deprecated runfile-based CUDA installation.";

		cudnn.enable = lib.mkEnableOption "cudnn, a GPU-accelerated library of primitives for deep neural networks.";

		libcutensor.enable = lib.mkEnableOption "libcutensor, a GPU-accelerated tensor linear algebra library for tensor contraction, reduction, and elementwise operations.";
	};

	config.environment.systemPackages = lib.concatLists (with pkgs; [
		(lib.optional cfg.cudnn.enable cudnn);
		(lib.optional cfg.cudatoolkit.enable cudatoolkit)
		(lib.optional cfg.libcutensor.enable libcutensor)
	]);
}