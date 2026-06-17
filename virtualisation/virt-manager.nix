{ config, lib, pkgs, ... }: let virt = config.programs.virt-manager.enable; in {

	# Whether to enable the virt-manager UI for managing libvirt virtual machines.
	programs.virt-manager.enable = true;

	virtualisation.libvirtd = {
		# Whether to enable the libvirtd daemon to manage virtual machines.
		enable = lib.mkIf virt true;

		qemu = {
			# vhost-user virtio-fs device backend.
			vhostUserPackages = lib.optional virt pkgs.virtiofsd;

			# When using an NVIDIA GPU, enable access to the EGL render node.
			# https://github.com/virt-manager/virt-manager/issues/938#issuecomment-3009548239
			verbatimConfig = lib.mkIf (config.hardware.activeGpu == "nvidia-proprietary") ''
				namespaces = []

				cgroup_device_acl = [
					"/dev/null", "/dev/full", "/dev/zero",
					"/dev/random", "/dev/urandom",
					"/dev/ptmx", "/dev/kvm",
					"/dev/nvidiactl", "/dev/nvidia0", "/dev/nvidia-modeset", "/dev/dri/renderD128"
				]

				seccomp_sandbox = 0
			'';
		};
	};

	# Allow drm device renderD* to be used for 3D acceleration when using NVIDIA drivers.
	# https://github.com/virt-manager/virt-manager/issues/938#issuecomment-3814628493
	services.udev.extraRules = lib.mkIf (config.hardware.activeGpu == "nvidia-proprietary") ''
		SUBSYSTEM=="drm", KERNEL=="renderD*", GROUP="render", MODE="0666"
	'';

	# Bridged networking setup.
	# BE CAREFUL! Change `enp16s0` to YOUR primary network interface.
	# You can see it with `ip a`.
	networking = lib.mkIf virt {
		bridges."br0".interfaces = [ "enp16s0" ];

		interfaces = {
			enp16s0.useDHCP = true;
			br0.useDHCP = true;
		};
	};

	# Add the user to the `libvirtd` group.
	users.users.${config.user.name}.extraGroups = lib.optional virt "libvirtd";
}