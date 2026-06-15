{ ... }: { zramSwap = {
	# Whether to enable in-memory compressed swap space provided by zram.
	enable = true;

	# Compression algorithm zram should use.
	algorithm = "zstd lz4 (type=huge)";

	# Maximum total amount of memory that can be stored in the zram swap devices.
	memoryPercent = 100;

	# Priority of the zram swap devices.
	# It should be a number higher than the priority of disk-based swap devices.
	priority = 100;
}; }