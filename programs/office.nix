{ pkgs, ... }: { programs = {
	# PFD rendering library.
	poppler-utils.enable = true;

	# Document viewer.
	xreader.enable = true;

	libreoffice = {
		# Whether to install LibreOffice, a comprehensive productivity suite.
		enable = true;

		# Which LibreOffice package to install.
		package = pkgs.libreoffice-fresh;
	};
}; }