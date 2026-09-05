{ config, lib, pkgs, ... }: { options.cursor = {
	name = lib.mkOption {
		type = lib.types.str;
		default = "Bibata-Modern-Ice";
		description = "The name of the cursor theme.";
	};

	package = lib.mkOption {
		type = lib.types.package;
		default = pkgs.bibata-cursors;
		description = "The package providing the cursor theme(s).";
	};

	size = lib.mkOption {
		type = lib.types.ints.positive;
		default = 24;
		description = "The size of the cursor.";
	};
}; }