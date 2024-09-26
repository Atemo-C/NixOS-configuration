# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Graphics
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=hardware.opengl.enable
# • https://search.nixos.org/options?channel=24.05&show=hardware.opengl.driSupport
# • https://search.nixos.org/options?channel=24.05&show=hardware.opengl.driSupport32Bit

{ config, ... }: { hardware.opengl = {

	# Whether to enable OpenGL drivers.
	enable = true;

	# Whether to enable accelerated OpenGL rendering through the Direct Rendering Interface (DRI).
	driSupport = true;

	#  On 64-bit systems, whether to support Direct Rendering for 32-bit applications (such as Wine).
	driSupport32Bit = true;

}; }
