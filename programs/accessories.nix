{ pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		# Offline password manager.
		keepassxc

		# Tool to write image files to portable media.
		# (e.g. ISO -> Bootable USB flash drive)
		mediawriter

		# Remote desktop client written in GTK.
		remmina

		# Tool to write Windows ISO files to USB flash drives.
		woeusb
	];

	# Workaround to make Fedora's Media Writer work when QT theming is enabled.
	nixpkgs.overlays = [
		(final: prev: {
			mediawriter = prev.mediawriter.overrideAttrs (oldAttrs: {
				nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ final.makeWrapper ];
				postFixup = (oldAttrs.postFixup or "") + ''
					wrapProgram $out/bin/mediawriter \
						--set QT_QPA_PLATFORMTHEME "gtk3" \
						--unset QT_STYLE_OVERRIDE
				'';
			});
		})
	];
}