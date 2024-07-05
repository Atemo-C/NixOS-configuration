{ pkgs, ... }: {

	# LXQT's image viewer.
	environment.systemPackages = with pkgs; [ unstable.lxqt.lximage-qt ];

}
