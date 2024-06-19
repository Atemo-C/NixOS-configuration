{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# YouTube player.
		freetube

		# MPV media player.
		mpv
	];

	# MPV plugins.
	nixpkgs.overlays = with pkgs; [
		(self: super: {
			mpv = super.mpv.override {
				scripts = [
					self.mpvScripts.mpris
					self.mpvScripts.sponsorblock
				];
			};
		})
	];

}
