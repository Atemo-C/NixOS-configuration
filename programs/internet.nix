{ config, lib, pkgs, ... }: { environment = rec {
	# Non-graphical programs.
	systemPackages = with pkgs; [
		amfora # CLI Gemini client.
		tor    # Anonymizing overlay network.

	# Graphical programs.
	] ++ lib.optionals config.programs.niri.enable (with pkgs; [
		element-desktop # Matrix client.
		lagrange        # Graphical Gemini client.
		librewolf       # Fork of the Firefox web browser focused on privacy and security.
		qbittorrent     # BitTorrent client.
		revolt-desktop  # Open-source Discord-like chat platform.
		ruffle          # Adobe Flash Player emulator.
		speedtest       # Graphical librespeed client.
		tor-browser     # Privacy-focused, Firefox-based browser routing traffic through the Tor network.
		vesktop         # Alternative Discord client with Vencord built-in.
	]);

	# Default web browser (change with the desired browser installed in `environment.systemPackages`).
	variables = lib.mkIf (lib.elem pkgs.librewolf systemPackages) { BROWSER = "librewolf"; };
}; }