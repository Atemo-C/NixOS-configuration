{ config, lib, ... }: lib.mkIf config.programs.niri.enable { home-manager.users.${config.userName}.services.dunst = {
	# Whether to display and send graphical notifications with Dunst.
	enable = true;

	# Use the icon theme defined for the user in the `./theming/icons.nix` module.
	iconTheme.package = config.home-manager.users.${config.userName}.gtk.iconTheme.package;
	iconTheme.name = config.home-manager.users.${config.userName}.gtk.iconTheme.name;

	# Dunst settings, written to `~/.config/dunst/dunstrc`.
	settings = {
		# Whether to calculate the DPI to use on a per-monitor basis.
		experimental.per_monitor_dpi = true;

		global = rec {
			# Which monitor should the notification be displayed on when using a multi-monitor setup.
			# • `none` = Let the Wayland compositor decide.
			# • `mouse` = Monitor focused by the mouse.
			# • `keyboard` = Monitor with a window focused by the keyboard.
			follow = "mouse";

			# The width and height of the notification, excluding the frame.
			# • `(minimum, maximum)` = dynamic size.
			# • `(value)` = constant size.
			height = "(16, 480)";
			width = "(16, 640)";

			# Horizontal and vertical offset from the corner of the screen in pixels.
			offset = "(6, 28)";

			# Maximum and minimum width for the progress bar in pixels.
			progress_bar_max_width = 600;
			progress_bar_min_width = 100;

			# Vertical and horizontal padding between text and separator in pixels.
			padding = 6;
			horizontal_padding = padding;

			# Width of the notification frame in pixels.
			frame_width = 2;

			# Color of the notification frame.
			frame_color = "#0080ff";

			# Size of the gaps to display between notifications in pixels.
			gap_size = 6;

			# Color for the separator.
			# • `auto` = Dunst automatically tries to find a color that fits the color scheme.
			# • `foreground` = The same as the foregroud color of the topmost notification.
			# • `frame` = The same as the frame color.
			# • `#ffffff` = Any valid color value.
			separator_color = "frame";

			# Use a font defined in the `./theming/fonts.nix` module.
			font = "monospace 12";

			# Path of the icon set to be used, defined in the `./theming/icons.nix` module.
			icon_path = "$HOME/.nix-profile/share/icons/${config.home-manager.users.${config.userName}.gtk.iconTheme.name}/status/scalable/16/:$HOME/.nix-profile/share/icons/${config.home-manager.users.${config.userName}.gtk.iconTheme.name}/devices/scalable/";

			# Define how markup is handled in notifications.
			# • `full` = Full markup support.
			# • `strip` = Less complete markup support, for legacy/broken clients.
			# • `no` = Disable markup parsing entirely.
			markup = "full";

			# Alignmement of the notification message text.
			alignment = "left";

			# Vertical alignment of notification message text and icon.
			# `top` | `center` | `bottom`
			vertical_alignment = "center";

			# Whether to enable the new icon lookup method.
			# You can set a single theme, instead of having to define all lookup paths.
			enable_recursive_icon_lookup = true;

			# Scale larger icons down to this size in pixels. Set to `0` to disable.
			max_icon_size = 64;

			# The command that will be run when opening a URL.
			# The `$BROWSER` variable is defined in the `./programs/internet.nix` module.
			browser = "$BROWSER";

			# Priority of notifications over other content.
			# • `bottom` = Bellow all windows and above the background.
			# • `top` = Above all non-fullscreen windows.
			# • `overlay` = Above everything.
			layer = "top";
		};

		# Settings for low-urgency notification messages.
		urgency_low = {
			background = "#1d1d1d";
			foreground = "#888888";
			frame_color = "#0000ff";
		};

		# Settings for normal-urgency notification messages.
		urgency_normal = {
			background = "#1d1d1d";
			foreground = "#ffffff";
		};

		# Settings for critical-urgency notification messages.
		urgency_critical = {
			background = "#281d1d";
			foreground = "#ffbfbf";
			frame_color = "#ff0000";
			timeout = 0;
		};
	};
}; }