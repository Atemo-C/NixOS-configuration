{ lib, ... }: {

	options.Custom = {
		Name = lib.mkOption { type = lib.types.str; };
		Title = lib.mkOption { type = lib.types.str; };
	};

}
