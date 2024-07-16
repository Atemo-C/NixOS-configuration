{ pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# 3D creation/animation/publishing system.
		blender
	];

}
