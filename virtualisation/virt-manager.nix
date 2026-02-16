{ config, lib, pkgs, ... }: {
	virtualisation.libvirtd = {
		# Whether to enable libvirtd, a daemon that manages virtual machines.
		enable = true;

		# When using an NVIDIA GPU, enable access to the EGL render node.
		# https://github.com/virt-manager/virt-manager/issues/938#issuecomment-3009548239
		qemu.verbatimConfig = lib.mkIf (lib.elem "nvidia" config.services.xserver.videoDrivers) ''
			namespaces = []

			cgroup_device_acl = [
				"/dev/null", "/dev/full", "/dev/zero",
				"/dev/random", "/dev/urandom",
				"/dev/ptmx", "/dev/kvm",
				"/dev/nvidiactl", "/dev/nvidia0", "/dev/nvidia-modeset", "/dev/dri/renderD128"
			]

			seccomp_sandbox = 0
		'';
	}

	# Allow drm device renderD* to be used for 3D acceleration when using NVIDIA drivers.
	# https://github.com/virt-manager/virt-manager/issues/938#issuecomment-3814628493
	services.udev.extraRules = lib.mkIf (lib.elem "nvidia" config.services.xserver.videoDrivers) ''
		SUBSYSTEM=="drm", KERNEL=="renderD*", GROUP="render", MODE="0666"
	'';

	# Add the user to the `libvirtd` group.
	users.users.${config.userName}.extraGroups = lib.optional config.virtualisation.libvirtd.enable "libvirtd";

	# Whether to enable the Virt Manager virtual machine manager.
	programs.virt-manager.enable = lib.mkIf config.virtualisation.libvirtd.enable true;
}