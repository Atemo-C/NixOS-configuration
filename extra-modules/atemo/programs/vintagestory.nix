{ config, lib, pkgs, ... }: let cfg = config.programs.vintagestory; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.vintagestory = {
		enable = lib.mkEnableOption ''
			Whether to enable the Vintage Story client, an in-development indie sandbox game about innovation and exploration.
		'';

		openFirewall = {
			lan = lib.mkEnableOption {
				description = ''
					Whether to open ports (42420 UDP+TCP) to allow for LAN multiplayer hosting.
				'';
			};

			global = lib.mkEnableOption {
				description = ''
					Whether to open port 1900 (UDP) to allow for UPnP auto-port-forwarding.
					This can (if your router is properly configured) allow you to open a world to the entire internet.
					Ports for LAN play are automatically opened too if this option is enabled.
				'';
			};
		};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ pkgs.vintagestory ];

		networking.firewall = {
			allowedTCPPorts = lib.optional (cfg.openFirewall.global || cfg.openFirewall.lan) 42420;

			allowedUDPPorts = [
				(lib.mkIf cfg.openFirewall.global "1900")
				(lib.mkIf (cfg.openFirewall.lan || cfg.openFirewall.global) "42420")
			];
		};
	};
}