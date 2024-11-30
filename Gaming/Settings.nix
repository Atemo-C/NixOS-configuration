# Documentation:
#───────────────
# • https://x.com/rpcs3/status/1330818231527944194
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.11&show=boot.kernel.sysctl
# • https://search.nixos.org/options?channel=24.11&show=security.pam.loginLimits

{ config, ... }: {

	# Runtime parameters of the Linux kernel as set by sysctl(8); Here, to future-proof for heavier games.
	boot.kernel.sysctl = { "vm.max_map_count" = 2147483642; };

	# Remove certain resource limits for programs that needs them gone, mostly for heavier emulators.
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
