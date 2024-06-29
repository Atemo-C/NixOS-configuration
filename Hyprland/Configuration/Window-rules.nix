{ config, ... }: {

	# Window rules.
	# https://wiki.hyprland.org/Configuring/Window-Rules/
	# https://wiki.hyprland.org/Configuring/Window-Rules/#window-rules-v2
	home-manager.users.${config.Custom.Name}.wayland.windowManager.hyprland.settings.windowrulev2 = [
		# Floating windows [By title].
		"float, title: (About*)"
		"float, title: (Authentication Required)"
		"float, title: (Blender Preferences)"
		"float, title: (Close LibreWolf)"
		"float, title: (File Operation Progress)"
		"float, title: (Opening *), class:(librewolf)"
		"float, title: (PCSX2 Settings)"
		"float, title: (Picture-in-Picture)"
		"float, title: (Steam Settings)"
		"float, title: (waypaper)"
		"float, title: (Xwayland on :12)"

		# Floating windows [By class].
		"float, class: (file-roller)"
		"float, class: (galculator)"
		"float, class: (.gamescope-wrapped)"
		"float, class: (gcolor*)"
		"float, class: (lxqt-policykit-agent)"
		"float, class: (scrcpy)"
		"float, class: (xdg-desktop-portal-gtk)"
		"float, class: (xfburn)"
		"float, class: (zenity)"

		# Tilling windows [By title].
		"tile, title: (Select an image)"
		"tile, title: (Kurso de Esperanto Kape)"

		# Event suppression [By title].
		"suppressevent maximize, title: (Revolt)"

		# Fullscreening windows [By class].
		"fullscreen, 1, class: (Better than Adventure*)"

		# XWayland videobridge-specific settings.
		"noanim, class: (xwaylandvideobridge)"
		"nofocus, class: (xwaylandvideobridge)"
		"noinitialfocus, class: (xwaylandvideobridge)"
		"opacity 0.0 override 0.0 override, class: (xwaylandvideobridge)"

		# CPU-X (TUI)-specific settings.
		"center, class: (CPU-X)"
		"float, class: (CPU-X)"
		"size 600 425, class: (CPU-X)"
	];

}
