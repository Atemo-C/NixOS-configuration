{ config, ... }: { services.openssh = {
	enable = true;
	ports = [ 4096 ];

	settings = {
		AllowUsers = [ "${config.user.name}" ];
		PermitRootLogin = "no";
	};

	startWhenNeeded = true;
}; }