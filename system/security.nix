{ ... }: { security = {
	# Whether to enable sudo.
	sudo.enable = false;

	# Whether to alias `sudo` to `run0`.
	run0.enableSudoAlias = true;
}; }