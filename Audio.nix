# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/PipeWire#Enabling_PipeWire
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.11&show=security.rtkit.enable
# • https://search.nixos.org/options?channel=24.11&show=services.pipewire.alsa.enable
# • https://search.nixos.org/options?channel=24.11&show=services.pipewire.alsa.support32Bit
# • https://search.nixos.org/options?channel=24.11&show=services.pipewire.enable
# • https://search.nixos.org/options?channel=24.11&show=services.pipewire.jack.enable
# • https://search.nixos.org/options?channel=24.11&show=services.pipewire.package
# • https://search.nixos.org/options?channel=24.11&show=services.pipewire.pulse.enable
# • https://search.nixos.org/options?channel=24.11&show=services.pipewire.wireplumber.package


{ config, pkgs, ... }: {

	# Whether to enable the RealtimeKit system service.
	# It hands out realtime scheduling priority to user processes on demand.
	# For example, some audio servers use this to acquire realtime priority.
	security.rtkit.enable = true;

	services.pipewire = {
		alsa = {
			# Whether to enable ALSA support.
			enable = true;

			# Whether to enable 32-bit ALSA support on 64-bit systems.
			support32Bit = true;
		};

		# Whether to enable PipeWire service.
		enable = true;

		# Whether to enable JACK audio emulation.
		jack.enable = true;

		# The pipewire package to use.
		package = pkgs.unstable.pipewire;

		# Whether to enable PulseAudio server emulation.
		pulse.enable = true;

		# The WirePlumber package to use.
		# Ideally, should be from the same branch as the PipeWire package uses.
		wireplumber.package = pkgs.unstable.wireplumber;
	};

}
