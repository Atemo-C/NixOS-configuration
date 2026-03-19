{ config, lib, pkgs, ... }: let cfg = config.programs.noctalia-shell; in {
	meta.maintainers = with lib.maintainers; [ atemo-c ];

	options.programs.noctalia-shell = {
		enable = lib.mkEnableOption "the Noctalia Shell, a beautiful, minimal desktop shell for Wayland that actually gets out of your way.";

		linkConfiguration = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Whether to link Noctalia Shell's configuration directory, from /etc/nixos/desktop/files/noctalia/ to ~/.config/noctalia/";
		};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = with pkgs; [ noctalia-shell ];

		systemd.user.tmpfiles.users.${config.user.name}.rules = lib.optional cfg.linkConfiguration "L %h/.config/noctalia/ - - - - /etc/nixos/desktop/files/noctalia/";
	};
}