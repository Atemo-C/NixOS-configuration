{ config, ... }: { home-manager.users.${config.userName}.xfconf.settings.xfce4-panel = {

	# Define the top panel.
	"panels" = [ 1 ];

	# Set the preference for dark mode for the top panel.
	"panels/dark-mode" = true;

	# Settings for the top panel.
	"panels/panel-1/icon-size" = 16;           # Set the icon size for elements in the pannel.
	"panels/panel-1/length" = 100;             # Make the pannel fill the current monitor.
	"panels/panel-1/position" = "p=6;x=0;y=0"; # Put the pannel on the top.
	"panels/panel-1/position-locked" = true;   # Lock the pannel's position.
	"panels/panel-1/size" = 26;                # Set the size of the pannel.

	# Plugin IDs for the top panel.
	"panels/panel-1/plugin-ids" = [ 1 2 3 4 5 6 7 8 9 10 11 12 13 ];

	# Plugin list for the top panel.
	"plugins/plugin-1" = "applicationsmenu";
	"plugins/plugin-2" = "tasklist";
	"plugins/plugin-3" = "separator";
	"plugins/plugin-4" = "pager";
	"plugins/plugin-5" = "separator";
	"plugins/plugin-6" = "screenshooter";
	"plugins/plugin-7" = "systray";
	"plugins/plugin-8" = "pulseaudio";
	"plugins/plugin-9" = "power-manager-plugin";
	"plugins/plugin-10" = "separator";
	"plugins/plugin-11" = "clock";
	"plugins/plugin-12" = "separator";
	"plugins/plugin-13" = "actions";

	# Plugin settings for the top panel.
	"plugins/plugin-1/show-tooltips" = true;
	"plugins/plugin-2/include-all-workspaces" = true;
	"plugins/plugin-3/expand" = true;
	"plugins/plugin-3/style" = 0;
	"plugins/plugin-5/expand" = true;
	"plugins/plugin-5/style" = 0;
	"plugins/plugin-10/style" = 0;
	"plugins/plugin-12/style" = 0;
	"plugins/plugin-13/appearance" = 1;
	"plugins/plugin-13/items" = [
		"-logout-dialog"
		"-switch-user"
		"-separator"
		"+logout"
		"+lock-screen"
		"+hibernate"
		"+hybrid-sleep"
		"+suspend"
		"+restart"
		"+shutdown"
	];

}; }
