{ pkgs, ... }: {

	# Suspend and resume management for devices on which systemctl suspend doesn't work.
	# Example: ThinkPad L510.
	environment.systemPackages = with pkgs; [ pmutils ];

}
