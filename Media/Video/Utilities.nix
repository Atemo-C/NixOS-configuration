{ pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# FFmpeg, the full package.
		ffmpeg_6-full

		# Open H.265 video codec implementation.
		libde265
	];


}
