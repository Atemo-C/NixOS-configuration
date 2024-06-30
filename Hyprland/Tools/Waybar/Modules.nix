{ config, ... }: {

	# Waybar modules.
	# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.waybar.settings
	# https://github.com/Alexays/Waybar/wiki/Configuration
	home-manager.users.${config.Custom.Name}.programs.waybar.settings.mainBar = {
		modules-left = [
			"image#Program_launcher" "custom/Spacer"
			"image#Power_menu" "custom/Spacer"
			"hyprland/workspaces"
		];

		modules-center = [
			"tray" "custom/Spacer"
			"image#Screenshot" "custom/Spacer"
			"image#Clipboard" "custom/Spacer"
			"image#Files" "custom/Spacer" "custom/Spacer"
			"clock" "custom/Spacer" "custom/Spacer"
			"image#CPU" "cpu" "temperature" "custom/Spacer"
			"image#RAM" "memory" "custom/Spacer"
			"image#Volume" "wireplumber" "custom/Spacer"
			"battery" "custom/Spacer"
		];

		modules-right = [
			"image#Reload" "custom/Spacer"
			"image#Exit" "custom/Spacer"
			"image#Close"
		];
	};

}
