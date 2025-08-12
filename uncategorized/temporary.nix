# Temporary fixes with links to the relevant issues when available.
# • Active workaroudns are activated.
# • Inactive workarounds are on the bottom, commented out. They are mostly here to remind me how to fix things.
{ config, lib, pkgs, ... }: {
	environment.etc = lib.mkIf (lib.elem "nvidia" config.services.xserver.videoDrivers) {
		# https://github.com/YaLTeR/niri/issues/1962
		"nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-niri.json".text = lib.mkIf
		config.programs.niri.enable ''
{
	"rules": [{
		"pattern": {
			"feature": "procname",
			"matches": "niri"
		},
		"profile": "Limit Free Buffer Pool on the Niri Wayland compositor"
	}],
	"profiles": [{
		"name": "Limit Free Buffer Pool on the Niri Wayland compositor",
		"settings": [{
			"key": "GLVidHeapReuseRatio",
			"value": 0
		}]
	}]
}
		'';

		# Add Firefox workarounds for NVIDIA GPUs to Librewolf.
		"nvidia/nvidia-application-profiles-rc.d/60-librewolf-firefox.json".text = lib.mkIf
		(lib.elem pkgs.librewolf config.environment.systemPackages) ''
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

	# https://github.com/NixOS/nixpkgs/issues/361592
	security.pam.services.systemd-run0 = {
		setEnvironment = true;
		pamMount = false;
	};

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