# Temporary fixes with links to the relevant issues when available.
# • Active workaroudns are activated.
# • Inactive workarounds are on the bottom, commented out. They are mostly here to remind me how to fix things.
{ config, lib, pkgs, ... }: {
	environment.etc = lib.mkIf (lib.elem "nvidia" config.services.xserver.videoDrivers) {
		# Apply various NVIDIA-specific fixes to various programs.
		# See the issue below as an example of what affected programs can act like otherwise.
		# https://github.com/YaLTeR/niri/issues/1962
		"nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-fix.json".text = builtins.toJSON {
			rules = map (proc: {
				pattern = {
					feature = "procname";
					matches = proc;
				};
				profile = "No VidMem Reuse";
			}) [
				".Discord-wrapped"
				".DiscordCanary-wrapped"
				"electron"
				".electron-wrapped"
				".Hyprland-wrapped"
				"losslesscut"
				"librewolf-wrapped"
				"librewolf"
				"niri"
			];
		};

		"nvidia/nvidia-application-profiles-rc.d/60-librewolf-firefox.json".text = ''
{
	"rules": [{
		"pattern": ".librewolf-wrapped",
		"profile": "ForceSeparateTrimThread",

		"pattern": ".librewolf-wrapped",
		"profile": "FA0",

		"pattern": ".librewolf-wrapped",
		"profile": "DedicatedHwStatePerCtx"
	}]
}
		'';
	};

#	# https://github.com/NixOS/nixpkgs/issues/361592
#	security.pam.services.systemd-run0 = {
#		setEnvironment = true;
#		pamMount = false;
#	};

# https://github.com/NixOS/nixpkgs/issues/404912
# https://github.com/NixOS/nixpkgs/pull/404963
#	nixpkgs.overlays = [
#		(self: super: {
#			mcpelauncher-client = super.mcpelauncher-client.overrideAttrs (oldAttrs: {
#				version = "1.3.0-qt6";
#				src = oldAttrs.src.override {
#					hash = "sha256-/I6hCnRSFHX30Gd0jErx5Uy/o8JCdYexsMRDKMUOWWI=";
#				};
#			});
#		})
#		(self: super: {
#			mcpelauncher-ui-qt = super.mcpelauncher-ui-qt.overrideAttrs (oldAttrs: {
#				src = oldAttrs.src.override {
#					hash = "sha256-333PwfBWhdfJSi1XrJNHidMYZrzSReb8s4VxBASFQ6Q=";
#				};
#			});
#		})
#	];
}