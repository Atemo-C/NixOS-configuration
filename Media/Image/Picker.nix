{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Screen color picker.
		unstable.hyprpicker

		# GUI color picker.
		gcolor3
	];

}
