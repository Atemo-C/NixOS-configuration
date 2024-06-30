{ config, ... }: {

	# CSS style of the bar.
	# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.waybar.style
	# https://github.com/Alexays/Waybar/wiki/Configuration
	home-manager.users.${config.Custom.Name}.programs.waybar.style = ''
		* {
			font-family: UbuntuMono Nerd Font;
			font-size: 16px;
			margin: 0;
			padding: 0;
		}

		#battery {
			font-size: 16px;
		}

		#button {
			border-radius: 0;
		}

		#custom-* {
			font-size: 20px;
		}

		#image {
			background-color: #000000;
			margin: 2px 2px;
			padding: 2px 2px;
		}

		tooltip {
			background: #242424;
			border: 2px solid #0080ff;
		}

		tooltip label {
			color: #ffffff;
		}

		window#waybar {
			background: #000000;
			color: #ffffff;
			border-bottom: 2px solid transparent;
		}

		#workspaces button {
			border-bottom: 2px solid transparent;
			color: #005ab3;
			padding: 0 10px;
			font-weight: bold;
		}

		#workspaces button.active {
			background-color: rgba(255, 255, 255, 0.2);
			border-bottom: 2px solid #ffffff;
			color: #00ffff;
		}

		#workspaces button.empty {
			color: #555555;
		}

		#workspaces button.urgent {
			background-color: rgba (255, 0, 0, 0.4);
		}
	'';

}
