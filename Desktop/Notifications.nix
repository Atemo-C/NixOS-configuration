{ config, pkgs, ... }: {

	# A library that sends desktop notifications to a notification daemon.
	environment.systemPackages = builtins.attrValues { inherit (pkgs) libnotify; };

	# Display notifications graphically with dunst.
	home-manager.users.${config.custom.name}.services.dunst = {
		# Whether to enable the dunst notification daemon.
		enable = true;

		# Configuration written to $XDG_CONFIG_HOME/dunst/dunstrc.
		settings = {
			global = {
				monitor = 0;
				follow = "none";
				width = "(0, 600)";
				height = "(0, 600)";
				origin = "top-right";
				offset = "5x29";
				scale = 0;
				notification_limit = 0;
				progress_bar = true;
				progress_bar_height = 10;
				progress_bar_min_width = 150;
				progress_bar_max_width = 600;
				indicate_hidden = "yes";
				transparency = 10;
				separator_height = 2;
				padding = 6;
				horizontal_padding = 6;
				text_icon_padding = 0;
				frame_width = 2;
				frame_color = "#0080ff";
				separator_color = false;
				sort = "yes";
				font = "UbuntuMono Nerd Font 12";
				line_height = 0;
				markup = "full";
				format = "<b>%s</b>%b";
				alignment = "left";
				vertical_alignment = "center";
				show_age_threshold = 60;
				ellipsize = "middle";
				ignore_newline = "no";
				stack_duplicates = true;
				hide_duplicate_count = false;
				show_indicators = "yes";
				icon_position = "left";
				min_icon_size = "0";
				max_icon_size = 32;
				sticky_history = "yes";
				history_length = 20;
				browser = "/run/current_system/sw/bin/xdg-open";
				always_run_script = true;
				title = "Dunst";
				class = "Dunst";
				corner_radius = 0;
				ignore_dbusclose = false;
				force_xwayland = false;
				force_xinerama = false;
				mouse_left_click = "close_current";
				mouse_middle_click = "do action, close_current";
				mouse_right_click = "close_all";
			};

			experimental.per_monitor_dpi = false;

			urgency_low = {
				background = "#1a1a1a";
				foreground = "#888888";
				timeout = 10;
			};

			urgency_normal = {
				background = "#1a1a1a";
				foreground = "#ffffff";
			};

			urgency_critical = {
				background = "#1a1a1a";
				foreground = "#ffffff";
				frame_color = "#ff0000";
				timeout = 0;
			};
		};
	};

}
