{ config, lib, pkgs, ... }: {
	boot = rec {
		# Enable systemd in initrd.
		# This allows better integration with Plymouth, LUKS password prompt, and more.
		initrd.systemd.enable = true;

		# Runtime parameters of the Linux Kernel to enhance performances in certain areas,
		# and to help future-proof without headaches.
		kernel.sysctl = {
			"kernel.sched_cfs_bandwidth_slice_us" = 3000;
			"net.ipv4.tcp_fin_timeout" = 5;
			"vm.max_map_count" = 2147483642;
		};

		# Select the Linux Kernel version to use.
		# https://wiki.nixos.org/wiki/Linux_kernel#List_available_kernels
		kernelPackages = pkgs.linuxPackages_zen;

		kernelParams = lib.concatLists [
			# Additional kernel parameters to help performances in certain areas.
			# This can also help with audio crackling, and other issues.
			"preempt=full"

			# Additional kernel parameters to make booting more silent when using Plymouth.
			(lib.optional plymouth.enable "quiet" )
			(lib.optional plymouth.enable "udev.log_level=3" )
			(lib.optional plymouth.enable "systemd.show_status=auto")
		];

		loader = {
			limine = {
				# Enable the Limine bootloader.
				enable = true;

				# Maximum number of latest generations to keep in the boot menu.
				# Lowering this value may help prevent the boot partition from running out of space.
				maxGenerations = 64;
			};

			# Timeout in seconds until the first entry in the bootloader is activated.
			# Use `null` if the menu should be displayed until the user manually selects an entry.
			timeout = 1;
		};

		plymouth = {
			# Enable the Plymouth boot splash screen.
			enable = true;

			# Use the "Deus Ex" Plymouth theme from adi1090x's Plymouth theme packs.
			theme = "deus_ex";
			themePackages = with pkgs; [
				(adi1090x-plymouth-themes.override { selected_themes = [ "deus_ex" ]; })
			];
		};

		# Use a more "silent" boot process when Plymouth is enabled.
		consoleLogLevel = lib.mkIf plymouth.enable 3;
		initrd.verbose = lib.mkIf plymouth.enable false;
	};

	services.kmscon = {
		# Enable kmscon as the virtual console instead of gettys.
		enable = true;

		# Enable mouse support in kmscon.
		extraConfig = "mouse";
	};

	# [C] Program that allows manually modifying the EFI boot manager entries.
	programs.efibootmgr.enable = true;
}