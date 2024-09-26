# Documentation:
#───────────────
# • https://alacritty.org/config-alacritty.html
#
# Used NixOS packages:
#─────────────────────
# • [lxterminal]
#   https://wiki.lxde.org/en/LXTerminal
#
# Used Home Manager options:
#───────────────────────────
# • https://nix-community.github.io/home-manager/options.xhtml#opt-programs.alacritty.enable
# • https://nix-community.github.io/home-manager/options.xhtml#opt-programs.alacritty.package
# • https://nix-community.github.io/home-manager/options.xhtml#opt-programs.alacritty.settings



{ config, pkgs, ... }: {

	# The standard terminal emulator of LXDE.
	environment.systemPackages = [ pkgs.lxterminal ];

	# A cross-platform, GPU-accelerated terminal emulator.
	home-manager.users.${config.custom.name}.programs.alacritty = {
		# Whether to enable Alacritty.
		enable = true;

		# The Alacritty package to install.
		package = pkgs.unstable.alacritty;

		# Alacritty configuration, written to $XDG_CONFIG_HOME/alacritty/alacritty.toml.
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
