{ config, pkgs, ... }: {

	# ST terminal emulator.
	environment.systemPackages = with pkgs; [ st ];

	# Patching ST with a local package.
#	nixpkgs.overlays = with pkgs; [
#		(final: prev: {
#			st = prev.st.overrideAttrs (
#				old: { src = /etc/nixos/ST ; }
#			);
#		})
#	];

	# Alacritty terminal emulator.
	home-manager.users.${config.Custom.Name}.programs.alacritty = {
		# Whether to enable Alacritty.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.alacritty.enable
		enable = true;

		# The Alacritty package to install.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.alacritty.package
		package = pkgs.unstable.alacritty;

		# Alacritty configuration, written to $XDG_CONFIG_HOME/alacritty/alacritty.toml.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.alacritty.settings
		settings = {
			window = {
				dynamic_padding = true;
				opacity = 0.8;
			};
			font = {
				normal = {
					family = "UbuntuMono Nerd Font";
					style = "Regular";
				};
				bold.style = "Bold";
				italic.style = "Italic";
				bold_italic.style = "Bold Italic";
				size = 12.0;
			};
			colors = {
				primary = {
					background = "#000000";
					foreground = "#eeeeee";
				};
				dim = {
					black = "#000000";
					blue = "#005ab3";
					cyan = "#00b3b3";
					green = "#00b300";
					magenta = "#b3005a";
					red = "#b30000";
					white = "#b3b3b3";
					yellow = "#b38600";
				};
				normal = {
					black = "#141414";
					blue = "#0080ff";
					cyan = "#00ffff";
					green = "#00ff00";
					magenta = "#ff0080";
					red = "#ff0000";
					white = "#e6e6e6";
					yellow = "#ffc000";
				};
				bright = {
					black = "#333333";
					blue = "#66b3ff";
					cyan = "#66ffff";
					green = "#66ff66";
					magenta = "#ff66b3";
					red = "#ff6666";
					white = "#ffffff";
					yellow = "#ffd966";
				};
			};
		};
	};

}
