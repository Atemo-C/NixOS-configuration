{ config, pkgs, ... }: {

	# The path to the user’s shell.
	# Don’t forget to enable your shell in programs if necessary, like programs.fish.enable = true;.
	users.users.${config.userName}.shell = pkgs.fish;

	programs.fish = {
		# Whether to configure FISH as an interactive shell.
		enable = true;

		# Set of FISH abbreviations.
		shellAbbrs = rec {
			# Short abbreviations.
			b = "btop";
			c = "clear";
			f = "fastfetch";
			h = "Hyprland";
			m = "micro";
			x = "exit";
			r = "run0";

			# Finding text in a directory.
			fdtext = ''grep -Rn -e "text"'';

			# Safer rm, cp, and mv.
			cp = "cp -v -i";
			cpdir = "cp -r -v -i";
			mv = "mv -v -i";
			rm = "rm -v -i";
			rmdir = "rm -d -r -v -i";

			# Going back more directories.
			"..." = "cd ../../";
			"...." = "cd ../../../";
			"....." = "cd ../../../../";

			# Remapping mouse extra button to F13.
			f13 = "run0 evsieve --input /dev/input/by-id/usb-1bcf_USB_Optical_Mouse-event-mouse grab --map btn:extra key:f13 --output";

			# Remapping mouse side buttons to LMB.
			lmb = "run0 evsieve --input /dev/input/by-id/usb-1bcf_USB_Optical_Mouse-event-mouse grab --map btn:side btn:left --map btn:extra btn:left --output";

			# Toggling recent files.
			enable-recent-files = "run0 rm -v -i ~/.local/share/recently-used.xbel";
			disable-recent-files = "run0 rm -v -i ~/.local/share/recently-used.xbel; run0 chattr -V +i ~/.local/share/recently-used.xbel";

			# NixOS.
			channel-list = "run0 nix-channel --list";
			channel-change = "run0 nix-channel --add https://channels.nixos.org/nixos-XX.XX nixos && micro /etc/nixos/User/Home-Manager.nix";
			nix-list = "run0 nixos-rebuild list-generations";
			nix-clean = "run0 nix-collect-garbage -d --quiet";
			nix-test = ''set -x CURRENTDIR $(pwd) && cd /tmp/ && run0 nixos-rebuild test --quiet; cd "$CURRENTDIR"'';
			nix-update-now = "run0 nixos-rebuild switch --quiet";
			nix-update-boot = "run0 nixos-rebuild boot --quiet";
			nix-upgrade-now = "run0 nixos-rebuild switch --upgrade --quiet";
			nix-upgrade-boot = "run0 nixos-rebuild boot --upgrade --quiet";

			# Flatpaks and FlatHub.
			enable-flathub = "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo";
			flatpak-upgrade = "flatpak update -y && flatpak remove --unused -y";
			flatpak-update = "flatpak update -y && flatpak remove --unused -y";

			# Online music.
			lofi-asian = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=Na0w3Mz46GA"'';
			lofi-christmas = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=pfiCNAc2AgU"'';
			lofi-escape = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=S_MOd40zlYU"'';
			lofi-jazz = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=HuFYqnbVbzY"'';
			lofi-piano = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=TtkFsfOP9QI"'';
			lofi-pov = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=uFlzUaisbig"'';
			lofi-rain = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=-OekvEFm1lo"'';
			lofi-sad = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=P6Segk8cr-c"'';
			lofi-sleep = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=28KRPhVzCus"'';
			lofi-study = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=jfKfPfyJRdk"'';
			lofi-synthwave = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=4xDzrJKXOOY"'';
			nightinthewoods = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=AsLKfqA73uE"'';
			tunic = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=gzWd5hjcaPo"'';

			# YT-DLP.
			yt = "yt-dlp";
			ytmp3 = "yt-dlp -x --audio-format mp3 --audio-quality 0";

			# FFmpeg.
			ffx = ''cd Downloads/YT-dlp && ffmpeg -hide_banner -i "https://url-here.m3u8" -c copy -bsf:a aac_adtstoasc name-here.mp4'';
			ffmpeg = "ffmpeg -hide_banner";

			# Image convertion and optimization.
			opti-jpg = "jpegoptim -s -v *.jpg";
			opti-jpeg = "jpegoptim -s -v *.jpeg";
			opti-png = "oxipng --strip all -v *.png";
			jpg-jxl = "parallel cjxl '{}' '{.}'.jxl -v ::: *.jpg";
			jpeg-jxl = "parallel cjxl '{}' '{.}'.jxl -v ::: *.jpeg";
			png-jxl = "parallel cjxl '{}' '{.}'.jxl -d 0 -v ::: *.png";
			jxl-jpg = "parallel djxl '{}' '{.}'.jpg -v ::: *.jxl";

			# List.
			l = "lsd --group-dirs first";
			list = l;

			# List all.
			la = "lsd --group-dirs first -A";
			list-all = la;

			# List long.
			ll = "lsd --group-dirs first -l";
			list-long = ll;

			# List tree.
			lt = "lsd --group-dirs first --tree";
			list-tree = lt;

			# List recursive.
			lr = "lsd --group-dirs first --recursive";
			list-recursive = lr;

			# List all+long.
			lal = "lsd --group-dirs first -Al";
			lla = lal;
			list-all-long = lal;
			list-long-all = lal;

			# List all+tree.
			lat = "lsd --group-dirs first -A --tree";
			lta = lat;
			list-all-tree = lat;
			list-tree-all = lat;

			# List all+recursive.
			lar = "lsd --group-dirs first -A --recursive";
			lra = lar;
			list-all-recursive = lar;
			list-recursive-all = lar;

			# List long+tree.
			llt = "lsd --group-dirs first -l --tree";
			ltl = llt;
			list-long-tree = llt;
			list-tree-long = llt;

			# List long+recursive.
			llr = "lsd --group-dirs first -l --recursive";
			lrl = llr;
			list-long-recursive = llr;
			list-recursive-long = llr;

			# List all+long+tree.
			lalt = "lsd --group-dirs first -Al --tree";
			latl = lalt;
			llta = lalt;
			llat = lalt;
			ltla = lalt;
			ltal = lalt;
			list-all-long-tree = lalt;
			list-all-tree-long = lalt;
			list-long-tree-all = lalt;
			list-long-all-tree = lalt;
			list-tree-long-all = lalt;
			list-tree-all-long = lalt;

			# List all+long+recursive.
			lalr = "lsd --group-dirs first -Al --recursive";
			larl = lalr;
			llra = lalr;
			llar = lalr;
			lrla = lalr;
			lral = lalr;
			list-all-long-recursive = lalr;
			list-all-recursive-long = lalr;
			list-long-recursive-all = lalr;
			list-long-all-recursive = lalr;
			list-recursive-long-all = lalr;
			list-recursive-all-long = lalr;
		};
	};

}
