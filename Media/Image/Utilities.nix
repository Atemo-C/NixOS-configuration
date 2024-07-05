{ pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Screenshots.
		unstable.hyprshot

		# Image optimisation.
		unstable.oxipng

		# AI upscailing.
		unstable.upscayl
	];

}
