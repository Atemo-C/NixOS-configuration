{ config, lib, pkgs, ... }: {
	boot = {
		initrd.systemd.enable = true;
		kernelPackages = pkgs.linuxPackages_zen;
		kernelParams = [ "preempt=full" ];

		loader = {
			limine = {
				enable = true;
				maxGenerations = 64;
			};

			timeout = 1;
		};

		plymouth = {
			enable = true;
			theme = "deus_ex";
			themePackages = with pkgs; [
				(adi1090x-plymouth-themes.override { selected_themes = [ "deus_ex" ]; })
			];
		};
	};

	services.kmscon = {
		enable = false;
		extraConfig = "mouse";
	};

	programs.efibootmgr.enable = lib.mkIf config.boot.loader.limine.efiSupport true;

	config.boot = lib.mkIf config.boot.plymouth.enable {
		consoleLogLevel = 3;
		initrd.verbose = false;
		kernelParams = [ "quiet" "udev.log_level=3" "systemd.show_status=auto" ];
	};
}