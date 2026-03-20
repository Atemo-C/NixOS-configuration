{ config, lib, pkgs, ... }: {
	virtualisation.libvirtd = {
		# Enable libvirtd, a daemon that manages virtual machines.
		enable = true;

		qemu = {
			# When using an NVIDIA GPU with proprietary drivers, enable access to the EGL render node.
			# https://github.com/virt-manager/virt-manager/issues/938#issuecomment-3009548239
			verbatimConfig = lib.mkIf (lib.elem "nvidia" config.services.xserver.videoDrivers) ''
				namespaces = []

				cgroup_device_acl = [
					"/dev/null", "/dev/full", "/dev/zero",
					"/dev/random", "/dev/urandom",
					"/dev/ptmx", "/dev/kvm",
					"/dev/nvidiactl", "/dev/nvidia0", "/dev/nvidia-modeset", "/dev/dri/renderD128"
				]

				seccomp_sandbox = 0
			'';

			# Include virtiofsd within libvirtd's QEMU instance.
			# This allows, for example, the use of shared folders between the host and guests.
			vhostUserPackages = [ pkgs.virtiofsd ];
		};
	};

	# Allow drm device renderD* to be used for 3D acceleration when using proprietary NVIDIA drivers.
	# https://github.com/virt-manager/virt-manager/issues/938#issuecomment-3814628493
	services.udev.extraRules = lib.mkIf (lib.elem "nvidia" config.services.xserver.videoDrivers) ''
		SUBSYSTEM=="drm", KERNEL=="renderD*", GROUP="render", MODE="0666"
	'';

	# Allow the `virbr0` network bridge through the firewall.
	networking.firewall.trustedInterfaces = [ "virbr0" ];

	# Add the user to the `libvirtd` group.
	users.users.${config.user.name}.extraGroups = [ "libvirtd" ];

	# Enable virt-manager, a UI for managing virtual machines in libvirt.
	programs.virt-manager.enable = true;
}