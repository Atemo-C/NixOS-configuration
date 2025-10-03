# https://github.com/CachyOS/CachyOS-Settings
{ config, lib, pkgs, ... }: {
	# Unlimited RT priority for audio.
	environment.etc."security/limits.d/20-audio.conf".text = ''@audio - rtprio 99'';

	# Use systemd-resolved as the default DNS resolver.
	services.resolved.enable = true;
	networking.networkmanager.dns = lib.mkIf config.services.resolved.enable "systemd-resolved";

	# https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/modprobe.d/amdgpu.conf
	# https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/modprobe.d/blacklist.conf
	# https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/modprobe.d/nvidia.conf
	boot.extraModprobeConfig = ''
		options amdgpu si_support=1 cik_support=1
		options radeon si_support=0 cik_support=0

		blacklist iTCO_wdt
		blacklist sp5100_tco
	'' + lib.optionalString (lib.elem "nvidia" config.services.xserver.videoDrivers) ''
		options nvidia NVreg_UsePageAttributeTable=1 \
			NVreg_InitializeSystemMemoryAllocations=0 \
			NVreg_DynamicPowerManagement=0x02
	'';

	# Load the ntsync module if available.
	boot.initrd.availableKernelModules = [ "ntsync" ];

	# Runtime parameters of the Linux Kernel set by sysctl.
	boot.kernel.sysctl = {
		"vm.swappiness" = 100;
		"vm.vfs_cache_pressure" = 50;
		"vm.dirty_bytes" = 268435456;
		"vm.page-cluster" = 1;
		"vm.dirty_background_bytes" = 67108864;
		"vm.dirty_writeback_centisecs" = 1500;
		"kernel.nmi_watchdog" = 0;
		"kernel.unprivileged_userns_clone" = 1;
		"kernel.printk" = "3 3 3 3";
		"kernel.kptr_restrict" = 2;
		"kernel.kexec_load_disabled" = 1;
		"net.core.netdev_max_backlog" = 4096;
		"fs.file-max" = 2097152;
	};

	# Journal size.
	services.journald.extraConfig = "SystemMaxUse=50M";

	systemd.settings.Manager = {
		# More responsive boot/shutdown by being less lenient towards unresponsive processes.
		DefaultTimeoutStartSec = "15s";
		DefaultTimeoutStopSec = "10s";

		DefaultLimitNOFILE = "2048:2097152";
	};

	# Time syncing settings.
	services.timesyncd = {
		servers = [ "time.cloudflare.com" ];
		fallbackServers = [
			"time.google.com"
			"0.arch.pool.ntp.org"
			"1.arch.pool.ntp.org"
			"2.arch.pool.ntp.org"
			"3.arch.pool.ntp.org"
		];
	};

	# Clear all coredumps that were created more than 3 days ago.
	systemd.coredump.extraConfig = "d /var/lib/systemd/coredump 0755 root root 3d";

	# https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/tmpfiles.d/thp-shrinker.conf
	# https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/tmpfiles.d/thp.conf
	systemd.tmpfiles.rules = [
		"w! /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none - - - - 409"
		"w! /sys/kernel/mm/transparent_hugepage/defrag - - - - defer+madvise"
	];

	# https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/udev/rules.d/20-audio-pm.rules
	services.udev.extraRules = ''
		ACTION=="add", SUBSYSTEM=="sound", KERNEL=="card*", DRIVERS=="snd_hda_intel", TEST!="/run/udev/snd-hda-intel-powersave", \
			RUN+="${pkgs.bash}/bin/bash -c 'touch /run/udev/snd-hda-intel-powersave; \
				[[ $$(cat /sys/class/power_supply/BAT0/status 2>/dev/null) != \"Discharging\" ]] && \
				echo $$(cat /sys/module/snd_hda_intel/parameters/power_save) > /run/udev/snd-hda-intel-powersave && \
				echo 0 > /sys/module/snd_hda_intel/parameters/power_save'"

		SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="0", TEST=="/sys/module/snd_hda_intel", \
			RUN+="${pkgs.bash}/bin/bash -c 'echo $$(cat /run/udev/snd-hda-intel-powersave 2>/dev/null || \
				echo 10) > /sys/module/snd_hda_intel/parameters/power_save'"

		SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="1", TEST=="/sys/module/snd_hda_intel", \
			RUN+="${pkgs.bash}/bin/bash -c '[[ $$(cat /sys/module/snd_hda_intel/parameters/power_save) != 0 ]] && \
				echo $$(cat /sys/module/snd_hda_intel/parameters/power_save) > /run/udev/snd-hda-intel-powersave; \
				echo 0 > /sys/module/snd_hda_intel/parameters/power_save'"

		ACTION=="change", KERNEL=="zram0", ATTR{initstate}=="1", SYSCTL{vm.swappiness}="150", \
			RUN+="/bin/sh -c 'echo N > /sys/module/zswap/parameters/enabled'"

		KERNEL=="rtc0", GROUP="audio"
		KERNEL=="hpet", GROUP="audio"

		ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", \
			ATTR{queue/scheduler}="bfq"

		ACTION=="add|change", KERNEL=="sd[a-z]*|mmcblk[0-9]*", ATTR{queue/rotational}=="0", \
			ATTR{queue/scheduler}="mq-deadline"

		ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", \
			ATTR{queue/scheduler}="none"

		DEVPATH=="/devices/virtual/misc/cpu_dma_latency", OWNER="root", GROUP="audio", MODE="0660"
	'' + lib.optionalString (lib.elem "nvidia" config.services.xserver.videoDrivers) ''
		ACTION=="add|bind", SUBSYSTEM=="pci", DRIVERS=="nvidia", \
			ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", \
			TEST=="power/control", ATTR{power/control}="auto"

		ACTION=="remove|unbind", SUBSYSTEM=="pci", DRIVERS=="nvidia", \
			ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", \
			TEST=="power/control", ATTR{power/control}="on"
	'';

#		ACTION=="add", SUBSYSTEM=="scsi_host", KERNEL=="host*", \
#			ATTR{link_power_management_policy}=="*", \
#			ATTR{link_power_management_policy}="max_performance"

#		ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", \
#			ATTRS{id/bus}=="ata", RUN+="/usr/bin/hdparm -B 254 -S 0 /dev/%k"

}