{ config, lib, ... }: {
	zramSwap = {
		enable = true;
		algorithm = if config.programs.lz4.enable then "zstd lz4 (type=huge)" else "zstd";
		memoryPercent = 100;
		priority = 100;
	};

	programs.lz4.enable = true;
}