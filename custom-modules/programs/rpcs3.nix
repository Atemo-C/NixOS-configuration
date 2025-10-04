{ config, lib, pkgs, ... }: let cfg = config.programs.rpcs3; in {
	options.programs.rpcs3 = {
		enable = lib.mkEnableOption "PS3 emulator/debugger";
		package = lib.mkPackageOption pkgs "rpcs3" {};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ cfg.package ];
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
	};
}