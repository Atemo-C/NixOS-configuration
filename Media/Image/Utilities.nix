{ pkgs, ... }: {

	environment.systemPackages = with pkgs.unstable; [
		# Screenshots.
		hyprshot

		# Image optimisation.
		oxipng
		jpegoptim

		# AI upscailing.
		upscayl
	];

}
