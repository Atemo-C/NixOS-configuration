{ config, pkgs, ... }: {

	# A library that sends desktop notification to a notification daemon.
	environment.systemPackages = [ pkgs.libnotify ];

	# Display notifications graphically with Dunst.
	home-manager.users.${config.userName}.services.dunst = {
		# Whteher to enable the dunst notification daemon.
		enable = true;

		# Dunst settings.
		settings = {
			global = rec {
				# Which monitor should the notifications be displayed on.
				monitor = 0;

				# Display notification on focused monitor.  Possible modes are:
				#   mouse: follow mouse pointer
				#   keyboard: follow window with keyboard focus
				#   none: don't follow anything
				#
				# "keyboard" needs a window manager that exports the _NET_ACTIVE_WINDOW property.
				# This should be the case for almost all modern window managers and Wayland compositors.
				#
				# If this option is set to mouse or keyboard, the monitor option will be ignored.
				follow = "mouse";

				# The width of the window, excluding the frame.
				# (value, vaule) = dynamic width.
				# value = constant width.
				width = "(1, 640)";

				# The height of the window, excluding the frame.
				# (value, vaule) = dynamic width.
				# value = constant width.
				height = "(1, 480)";

				# Position the notification on the monitor.
				origin = "top-right";

				# Offset from the origin.
				offset = "(6, 28)";

				# Scale factor. It is auto-detected if the value is `0`.
				scale = 0;

				# Whether to turn on the progress bar.
				# It appears when a progress hint is passed with, for example, `dunstify -h int:value:12`
				progress_bar = true;

				# Set the progress bar height.
				# This includes the frame, so make sure it is at least twice as big as the frame width.
				progress_bar_height = 10;

				# Set the minimum width for the progress bar.
				progress_bar_min_width = 100;

				# Set the maximum width for the progress bar.
				progress_bar_max_width = 600;

				# Corner radius for the progress bar. 0 disables rounded corners.
				progress_bar_corner_radius = 0;

				# Define which corners to round when drawing the progress bar.
				# If `progress_bar_corner_radius` is set to `0`, this option will be ignored.
				progress_bar_corners = "all";

				# Corner radius for the icon image.
				icon_corner_radius = 6;

				# Define which corners to round when drawing the icon image.
				# If `icon_corner_radius` is set to `0`, this optin will be ignored.
				icon_corners = "all";

				# Show how many messages are currently hidden because of notification_limit.
				indicate_hidden = "yes";

				# The transparency of the window. [0; 100].
				# This option will only work if compositing is working in your environment.
				transparency = "10";

				# Draw a line of "separator_height" pixel height between two notifications.
				# Set to `0` to disable.
				# If `gap_size` is greater than `0`, this setting will be ignored.
				separator_height = 2;

				# Padding between text and separator.
				padding = 6;

				# Horizontal padding.
				horizontal_padding = padding;

				# Padding between text and icon.
				text_icon_padding = 0;

				# Define the width in pixels of the frame around the notification window.
				frame_width = 2;

				# Define the color of the frame around the notification window.
				frame_color = "#0080ff";

				# Size of the gap to display between notifications.
				# If the value is greater than `0`, `separator_height` will be ignored, and a border of size `frame_width`
				# will be drawn around each notification instead.
				# Click events on gaps do not currently propagate to applications below.
				gap_size = 3;

				# Define a color for the separator.
				separator_color = frame_color;

				# Whether to enable sorting of notification by id, urgency, or update.
				sort = "yes";

				# The spacing between lines.
				# If the height is smaller than the font height, it will get raised to the font height.
				line_height = 0;

				# Amount of markup style to allow.
				markup = "full";

				# The format of the notification messages.
				format = "<b>%s</b>\n%b";

				# Alignement of the notification messages text.
				alignment = "left";

				# Vertical alignement of notification message text and icon.
				vertical_alignment = "center";

				# Show age of notification messages if they are older than `show_age_threshold` seconds.
				# Set to -1 to diasble.
				show_age_threshold = 60;

				# Specifiy where to make an ellipsis in long lines.
				ellipsize = "middle";

				# Whether to ignore newlines '\n' in notifications.
				ignore_newlines = "no";

				# Whether to stack together notifications with the same content.
				stack_duplicates = true;

				# Whether to hide the count of stacked notifications with the same content.
				hide_duplicate_count = false;

				# Whether to display indicators for URLs (U) and actions (A).
				show_indicators = "no";

				# Whether to enable recursive icon lookup.
				# You can set a single theme, instead of having to define all lookup paths.
				enable_recursive_icon_lookup = true;

				# Align icons to a direction.
				icon_position = "left";

				# Scale small icons up to this size. Set to `0` to disable.
				# Helpful for e.g. small files or high-dpi monitors.
				# In case of conflicts, `max_icon_size` takes precedence over this.
				min_icon_size = 32;

				# Scale larger icons down to this size. Set to `0` to disable.
				max_icon_size = 42;

				# Whether a notification popped up from history should be sticky or timeout as if it would normally do.
				sticky_history = "yes";

				# Maximum amount of notifications kept in history.
				history_length = "20";

				# Browser for opening URLs in context menu.
				browser = "/run/current-system/sw/bin/librewolf";

				# Whether to always run rule-defined scripts, even if the notification is suppressed.
				always_run_script = true;

				# Define the title of the windows spawned by dunst (X11).
				title = "Dunst";

				# Define the class of the windows spawned by dunst (X11).
				class = "Dunst";

				# Define the corner radius of the notification in pixel size.
				# If the radius is `0`, you have no rounded corners.
				corner_radius = 0;

				# Define which corners to round when drawing the window.
				# If the corner radius is set to `0`, this option will be ignored.
				corners = "all";

				# Whether to ignore the dbus closeNotification message.
				# Useful to enforce the timeout set by dunst configuration.
				# Without this parameter, an application may close the notification sent before the user define timeout.
				ignore_dbusclose = false;

				# Whether to let notifications appear under fullscreen applications (Wayland).
				# overlay = no, top = yes.
				layer = "top";

				# Whether to force the use of XWayland (Wayland).
				force_xwayland = false;

				# Define the list of action for each mouse event.
				mouse_left_click = "close_current";
				mouse_middle_click = "do_action, close current";
				mouse_right_click = "close_all";
			};

			# Whether to calculate the DPI to use on a per-monitor basis.
			experimental.per_monitor_dpi = true;

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
				foreground = "#ff8080";
				frame_color = "#ff0000";
				timeout = 0;
			};
		};
	};
}
