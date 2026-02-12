{ pkgs, ... }: { programs = {
	# PDF rendering library.
	poppler-utils.install = true;

	# Document viewer.
	xreader.install = true;

	libreoffice = {
		# Whether to enable the LibreOffice suite.
		enable = true;

		# Which package to use for LibreOffice.
		package = pkgs.libreoffice-fresh;
	};
}; }