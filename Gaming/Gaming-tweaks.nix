{ config, ... }: {

	boot = {
		# Runtime parameters of the Linux Kernel to enhance gaming performance and to help future-proof.
		kernel.sysctl = {
			"kernel.sched_cfs_bandwidth_slice_us" = 3000;
			"net.ipv4.tcp_fin_timeout" = 5;
			"vm.max_map_count" = 2147483642;
		};

		# Additional kernel parameters to help.
		kernelParams = [ "preempt=full" ];
	};

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

	# Use the newest kernel thread scheduler.
	services.scx = {
		enable = true;
		scheduler = "scx_lavd";
	};

}
