{ config, lib, pkgs, ... }: lib.mkMerge [
	{
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

		programs.efibootmgr.enable = lib.mkIf config.boot.loader.limine.efiSupport true;
	}

	(lib.mkIf config.boot.plymouth.enable { boot = {
		consoleLogLevel = 3;
		initrd.verbose = false;
		kernelParams = [
			"quiet"
			"udev.log_level=3"
			"systemd.show_status=auto"
		];
	}; })
]