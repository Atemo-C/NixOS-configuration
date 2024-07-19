{ config, pkgs, ... }: {

	services.minecraft-server.TestServer = {
		# Whether to enable auto-starting of the Minecraft server with the system.
		# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.autostart
		autostart = false;

		# Minecraft server backups.
		backups = {
			# Directory to store the Minecraft server's backups.
			# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.backups.directory
			directory = "${services.minecraft-server.TestServer.dataDir}/TestServer-backups";

			# Interval between server backups.
			# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.backups.interval
			interval = "manual";

			# What to back-up during backups.
			# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.backups.toBackup
			toBackup = [ "everything" ];

			# What not to back-up during backups. To be used when toBackup is set to "everything".
			# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.backups.noBackup
			noBackup = [
				"mods"
				"logs"
			];
		};

		# Directory to store the Minecraft server's data.
		# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.dataDir
		dataDir = "/var/lib/mincraft/TestServer";

		# Whether to use a declarative Minecraft server configuration.
		# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.declarative
		declarative = true;

		# If enabled, create and manage a Minecraft server.
		# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.enable
		enable = true;

		# Start/stop command for the Minecraft server.
		cmd = {
			# Whether to enable a start/stop command for the Minecraft server.
			# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.cmd.enable
			enable = true;

			# What the command name should be to start the Minecraft server.
			# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.cmd.startCmd
			startCmd = "test-server-start";

			# What the command name should be to stop the Minecraft server.
			# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.cmd.stopCmd
			stopCmd = "test-server-stop";
		};

		# Whether you agree to Mojang's EULA. Must be set to true to run the Minecraft server.
		# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.eula
		eula = true;

		# JVM options for the Minecraft server.
		# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.jvmOpts
		jvmOpts = "-Xms4G -Xmx10G";

		# Mods for the Minecraft server.
		mods = {
			# Whether to automatically update mods before server startup.
			# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.mods.autoUpdate
			autoUpdate = true;

			# Mods from Modrinth for the fabric Minecraft server.
			# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.mods.fabric.modrinth
			fabric.modrinth = [
				"gvQqBUqZ" # Lithium
				"uXXizFIs" # Ferrite Core
				"nmDcB62a" # Modern Fix
				"fQEb0iXm" # Krypton
				"QwxR6Gcd" # Debugify
				"VSNURh3q" # Concurrent Chunk Management Engine
				"vE2FN5qn" # Let Me Despawn
				"KuNKN7d2" # Noisium
				"4WWQxlQP" # ServerCore
				"r0v8vy1s" # Alternate Current
				"RfFxanNh" # Faster Random
				"T0OUgf8P" # Get It Together,Drops!
				"7LEWYKTV" # RecipeCooldown
				"Ps1zyz6x" # ScalableLux
			];
		};

		# Whether to open ports in the firewall for the server.
		# Which port is used can be defined in services.minecraft-server.<name>.serverProperties.
		# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.openFirewall
		openFirewall = true;

		# The minecraft-server package to use.
		# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.package
		package = pkgs.minecraftServer.fabric-1-21;

		# Minecraft server properites for the server.properties file.
		# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.serverProperties
		serverProperties = {
			difficulty = "normal";
			enable-command-block = true;
			enforce-whitelist = true;
			gamemode = "creative";
			level-name = "test-world";
			level-seed = "-4446806965030196823";
			max-players = 6;
			max-world-size = 1000000;
			modt = "Test server";
			server-port = 69420;
			white-list = true;
		};

		# Using the screen utiltity to connect to the Minecraft server's console through a terminal emulator.
		screen = {
			# Whether to enable the use of the screen utility to connect to the Minecraft server's console.
			# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.screen.enable
			enable = true;

			# What name the screen sesion should use.
			# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.screen.name
			name = "test-server-scr";
		};

		# Whitelisted players, active if white-list is set to true.
		# https://search.nixos.org/options?channel=24.05&show=services.minecraft-server.%3Cname%3E.whitelist
		whitelist = {
			username1 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
			username2 = "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy";
		};
	};

}
