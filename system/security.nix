{ ... }: { security = {
	# Whether to enable sudo.
	sudo.enable = false;

	run0 = {
		# Whether to enable `run0`.
#		enable = true;

		# Whether to alias `sudo` to `run0`.
		enableSudoAlias = true;
	};
}; }