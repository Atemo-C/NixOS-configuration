{ config, pkgs, ... }: {

	home-manager.users.${config.Custom.Name}.gtk.font = {
		name = "UbuntuMono Nerd Font";
		size = 11;
	};

}
