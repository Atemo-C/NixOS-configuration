{ config, lib, pkgs, ... }: {
	environment = {
		systemPackages = with pkgs; [
			# Non-graphical programs.
			amfora # CLI Gemini client.
			tor    # Anonymizing overlay network.

			# Graphical programs.
		] ++ lib.optionals config.programs.niri.enable (with pkgs; [
			element-desktop # Matrix client.
			lagrange        # Graphical Gemini client.
			qbittorrent     # BitTorrent client.
			revolt-desktop  # Open-source Discord-like chat platform.
			ruffle          # Adobe Flash Player emulator.
			speedtest       # Graphical librespeed client.
			tor-browser     # Privacy-focused, Firefox-based browser routing traffic through the Tor network.
			vesktop         # Alternative Discord client with Vencord built-in.
		]);

		# Default web browser to use.
		variables.BROWSER = lib.mkIf (
			config.programs.firefox.enable && config.programs.firefox.package == pkgs.librewolf
		) "librewolf";
	};

	# Whether to install the Firefox web browser.
	programs.firefox.enable;

	# Which package of Firefox (or fork of it) to install.
	programs.firefox.package = pkgs.librewolf;
}