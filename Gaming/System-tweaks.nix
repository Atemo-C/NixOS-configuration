{ config, ... }: {

	# Runtime parameters of the Linux kernel for future-proofing for heavier and heavier games.
	# https://search.nixos.org/options?channel=24.05&show=boot.kernel.sysctl
	boot.kernel.sysctl = { "vm.max_map_count" = 2147483642; };

	# Remove certain limits for programs that needs them gone, mostly for big emulators.
	# https://search.nixos.org/options?channel=24.05&show=security.pam.loginLimits
	security.pam.loginLimits = [
		{
			domain = "*";
			type = "hard";
			item = "memlock";
			value = "unlimited";
		}
		{
			domain = "*";
			type = "soft";
			item = "memlock";
			value = "unlimited";
		}
	];

}
