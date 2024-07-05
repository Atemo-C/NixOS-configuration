{ pkgs, ... }: {

	# Enable the use of AppImages with the appimage-run command.
	environment.systemPackages = with pkgs; [ appimage-run ];

}
