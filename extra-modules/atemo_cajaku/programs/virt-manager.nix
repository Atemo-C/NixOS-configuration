{ config, lib, pkgs, ... }: let
	cfg = config.programs.virt-manager;
	nvidia = lib.elem "nvidia" config.services.xserver.videoDrivers
in {
	config = lib.mkIf cfg.enable {
		qemu = {
			verbatimConfig = lib.mkIf nvidia ''
				namespaces = []

				cgroup_device_acl = [
					"/dev/null", "/dev/full", "/dev/zero",
					"/dev/random", "/dev/urandom",
					"/dev/ptmx", "/dev/kvm",
					"/dev/nvidiactl", "/dev/nvidia0", "/dev/nvidia-modeset", "/dev/dri/renderD128"
				]

				seccomp_sandbox = 0
			'';

			vhostUserPackages = [ pkgs.virtiofsd ];
		};
	};

	services.udev.extraRules = lib.mkIf nvidia
	''SUBSYSTEM=="drm", KERNEL=="renderD*", GROUP="render", MODE="0666"'';

	users.users.${config.user.name}.extraGroups = [ "libvirtd" ];
}