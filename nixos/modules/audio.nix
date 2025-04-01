{ ... }:

{
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;

		# Optional if you use JACK (disabled for now)
		# jack.enable = true;
	};

	services.pulseaudio.enable = false; # legacy, disable it
	security.rtkit.enable = true;
}

