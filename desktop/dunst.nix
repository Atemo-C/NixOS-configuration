{ config, lib, ... }: lib.mkIf config.programs.niri.enable { home-manager.users.${config.userName} = rec {
	# Whether to display and send graphical notifications with Dunst.
	services.dunst.enable = true;

	# Use the icon theme defined for the user in the `./theming/icons.nix` module.
	services.dunst.iconTheme.package = config.home-manager.users.${config.userName}.gtk.iconTheme.package;
	services.dunst.iconTheme.name = config.home-manager.users.${config.userName}.gtk.iconTheme.name;
	services.dunst.settings.global.icon_path = "$HOME/.nix-profile/share/icons/${config.home-manager.users.${config.userName}.gtk.iconTheme.name}/status/scalable/16/:$HOME/.nix-profile/share/icons/${config.home-manager.users.${config.userName}.gtk.iconTheme.name}/devices/scalable/";

	# Link the configuration file for Dunst.
	systemd.user.tmpfiles.rules = lib.optional config.service.dunst.enable;
	"L %h/.config/dunst/dunstrc - - - - /etc/nixos/desktop/files/dunst.conf"
}; }