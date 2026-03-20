{ ... }: {
	zramSwap = {
		# Enable in-memory compression devices and swap space provided by the zram kernel module.
		enable = true;

		# Compression algorithm to use.
		algorithm = "zstd lz4 (type=huge)";

		# Percentage of memory that can be stored in the zram swap devices.
		memoryPercent = 100;

		# Priority of the zram swap devices.
		# It should be a number higher than the priority of your disk-based swap devices,
		# so that the system will fill the zram swap device before falling back to disk swap.
		priority = 100;
	};

	# Install lz4 for better zram compression.
	programs.lz4.enable = true;
}