{ ... }: { programs = {
	# `cat (1)` clone with syntax highlighting and Git integration.
	bat.enable = true;

	# GNU software calculator.
	bc.enable = true;

	# Calendar and scheduling applicatoin for the command-line.
	calcurse.enable = true;

	# Whether interactive shells should show which Nix package (if any) provides a missing command.
	command-not-found.enable = true;

	# GitHub CLI tool.
	gh.enable = true;

	# Distributed version control system.
	git.enable = true;

	# Lightweight and flexible command-line JSON processor.
	jq.enable = true;

	# Shell tool for executing jobs in parallel.
	parallel.enable = true;

	# Shell script analysis tool.
	shellcheck.enable = true;

	# Simplified and community-driven man pages.
	tlrc.enable = true;

	# Tool for retrieving files using HTTP, HTTPS, and FTP.
	wget.enable = true;
}; }