{ pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# TUI Gemini browser.
		amfora

		# GUI Gemini browser.
		lagrange
	];

}
