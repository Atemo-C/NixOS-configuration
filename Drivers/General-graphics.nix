# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Graphics
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.11&show=hardware.graphics.enable
# • https://search.nixos.org/options?channel=24.11&show=hardware.graphics.enable32Bit

{ config, ... }: { hardware.graphics = {

	# Whether to enable hardware accelerated graphics drivers.
	enable = true;

	# On 64-bit systems, whether to also install 32-bit drivers for 32-bit applications (such as Wine).
	enable32Bit = true;

}; }
