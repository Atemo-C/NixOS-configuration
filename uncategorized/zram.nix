{ ... }: { zramSwap = {
	# Whether to enable in-memory compression devices and swap space provided by the zram kernel module.
	# https://www.kernel.org/doc/Documentation/blockdev/zram.txt
	enable = true;

	# Compression algorithm to use.
	algorithm = "zstd lz4 (type=huge)";

	# Maximum total amount of memory that can be stored in the zram swap devices,
	# as a percentage of your total memory.
	memoryPercent = 100;

	# Priority of the zram swap devices.
	# It should be a number higher than the priority of your disk-based swap devices,
	# so that the system will fill the zram swap device before falling back to disk swap.
	priority = 100;
}; }