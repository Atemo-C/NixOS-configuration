{ config, ... }: {

	services.openssh.settings = {
		AllowUsers = username;
		PermitRootLogin = "no";
	};

}
