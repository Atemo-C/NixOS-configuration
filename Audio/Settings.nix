{ config, ... }: {

	services.pipewire = {
		alsa = {
			# Whether to enable ALSA support.
			# https://search.nixos.org/options?channel=24.05&show=services.pipewire.alsa.enable
			enable = true;

			# Whether to enable 32-bit ALSA support.
			# https://search.nixos.org/options?channel=24.05&show=services.pipewire.alsa.support32Bit
			support32Bit = true;
		};

		# Whether to enable PipeWire.
		# https://search.nixos.org/options?channel=24.05&show=services.pipewire.enable
		enable = true;

		# Whether to enable JACK audio emulation.
		# https://search.nixos.org/options?channel=24.05&show=services.pipewire.jack.enable
		jack.enable = true;

		# Whether to enable PulseAudio server emulation.
		# https://search.nixos.org/options?channel=24.05&show=services.pipewire.pulse.enable
		pulse.enable = true;
	};

}
