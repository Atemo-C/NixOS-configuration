{ config, pkgs, ... }: {

	# The path to the user’s shell.
	# Don’t forget to enable your shell in programs if necessary, like programs.fish.enable = true;.
	users.users.${config.custom.name}.shell = pkgs.fish;

	programs.fish = {
		# Whether to configure FISH as an interactive shell.
		enable = true;

		# Set of FISH abbreviations.
		shellAbbrs = {
			# Short abbreviations.
			b = "btop";
			c = "clear";
			f = "fastfetch";
			h = "Hyprland";
			m = "micro";
			x = "exit";

			# Finding text in a directory.
			fdtext = ''grep -Rn -e "text"'';

			# Safer rm, cp, and mv.
			cp = "cp -v -i";
			cpdir = "cp -r -v -i";
			mv = "mv -v -i";
			rm = "rm -v -i";
			rmdir = "rm -d -v -i";

			# Remapping mouse extra button to F13.
			f13 = "sudo evsieve --input /dev/input/by-id/usb-1bcf_USB_Optical_Mouse-event-mouse grab --map btn:extra key:f13 --output";

			# Remapping mouse side buttons to LMB.
			lmb = "sudo evsieve --input /dev/input/by-id/usb-1bcf_USB_Optical_Mouse-event-mouse grab --map btn:side btn:left --map btn:extra btn:left --output";

			# Toggling recent files.
			enable-recent-files = "sudo rm -v -i ~/.local/share/recently-used.xbel";
			disable-recent-files = "sudo rm -v -i ~/.local/share/recently-used.xbel; sudo chattr -V +i ~/.local/share/recently-used.xbel";

			# NixOS.
			channel-list = "sudo nix-channel --list";
			channel-upgrade = "sudo nix-channel --add https://channels.nixos.org/nixos-XX.XX nixos && micro /etc/nixos/User/Home-Manager.nix";
			nix-clean = "sudo nix-collect-garbage -d --quiet";
			nix-update-now = "sudo nixos-rebuild switch --use-remote-sudo --quiet";
			nix-update-boot = "sudo nixos-rebuild boot --use-remote-sudo --quiet";
			nix-upgrade-now = "sudo nixos-rebuild switch --upgrade --use-remote-sudo --quiet";
			upgrade-boot = "sudo nixos-rebuild boot --upgrade --use-remote-sudo --quiet";

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
			lofi-rain = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=-OekvEFm1lo"'';
			lofi-sleep = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=28KRPhVzCus"'';
			lofi-study = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=jfKfPfyJRdk"'';
			lofi-synthwave = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=4xDzrJKXOOY"'';
			nightinthewoods = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=AsLKfqA73uE"'';
			tunic = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=gzWd5hjcaPo"'';

			# YT-DLP.
			yt = "yt-dlp";
			ytmp3 = "yt-dlp -x --audio-format mp3 --audio-quality 0";

			# FFmpeg.
			ffx = ''cd Downloads/YT-dlp && ffmpeg -i "https://url-here.m3u8" -c copy -bsf:a aac_adtstoasc name-here.mp4'';

			# Image convertion and optimization.
			opti-jpg = "jpegoptim -s -v *.jpg";
			opti-jpeg = "jpegoptim -s -v *.jpeg";
			opti-png = "oxipng --strip all -v *.png";
			jpg-jxl = "parallel cjxl '{.}' '{.}'.jxl -v ::: *.jpg";
			jpeg-jxl = "parallel cjxl '{.}' '{.}'.jxl -v ::: *.jpeg";
			png-jxl = "parallel cjxl '{.}' '{.}'.jxl -d 0 -v ::: *.png";

			# List.
			l = "lsd --group-dirs first";
			list = "lsd --group-dirs first";

			# List all.
			la = "lsd --group-dirs first -A";
			list-all = "lsd --group-dirs first -A";

			# List long.
			ll = "lsd --group-dirs first -l";
			list-long = "lsd --group-dirs first -l";

			# List tree.
			lt = "lsd --group-dirs first --tree";
			list-tree = "lsd --group-dirs first --tree";

			# List recursive.
			lr = "lsd --group-dirs first --recursive";
			list-recursive = "lsd --group-dirs first --recursive";

			# List all+long.
			lal = "lsd --group-dirs first -Al";
			lla = "lsd --group-dirs first -Al";
			list-all-long = "lsd --group-dirs first -Al";
			list-long-all = "lsd --group-dirs first -Al";

			# List all+tree.
			lat = "lsd --group-dirs first -A --tree";
			lta = "lsd --group-dirs first -A --tree";
			list-all-tree = "lsd --group-dirs first -A --tree";
			list-tree-all = "lsd --group-dirs first -A --tree";

			# List all+recursive.
			lar = "lsd --group-dirs first -A --recursive";
			lra = "lsd --group-dirs first -A --recursive";
			list-all-recursive = "lsd --group-dirs first -A --recursive";
			list-recursive-all = "lsd --group-dirs first -A --recursive";

			# List long+tree.
			llt = "lsd --group-dirs first -l --tree";
			ltl = "lsd --group-dirs first -l --tree";
			list-long-tree = "lsd --group-dirs first -l --tree";
			list-tree-long = "lsd --group-dirs first -l --tree";

			# List long+recursive.
			llr = "lsd --group-dirs first -l --recursive";
			lrl = "lsd --group-dirs first -l --recursive";
			list-long-recursive = "lsd --group-dirs first -l --recursive";
			list-recursive-long = "lsd --group-dirs first -l --recursive";

			# List all+long+tree.
			lalt = "lsd --goup-dirs first -Al --tree";
			latl = "lsd --goup-dirs first -Al --tree";
			llta = "lsd --goup-dirs first -Al --tree";
			llat = "lsd --goup-dirs first -Al --tree";
			ltla = "lsd --goup-dirs first -Al --tree";
			ltal = "lsd --goup-dirs first -Al --tree";
			list-all-long-tree = "lsd --goup-dirs first -Al --tree";
			list-all-tree-long = "lsd --goup-dirs first -Al --tree";
			list-long-tree-all = "lsd --goup-dirs first -Al --tree";
			list-long-all-tree = "lsd --goup-dirs first -Al --tree";
			list-tree-long-all = "lsd --goup-dirs first -Al --tree";
			list-tree-all-long = "lsd --goup-dirs first -Al --tree";

			# List all+long+recursive.
			lalr = "lsd --goup-dirs first -Al --recursive";
			larl = "lsd --goup-dirs first -Al --recursive";
			llra = "lsd --goup-dirs first -Al --recursive";
			llar = "lsd --goup-dirs first -Al --recursive";
			lrla = "lsd --goup-dirs first -Al --recursive";
			lral = "lsd --goup-dirs first -Al --recursive";
			list-all-long-recursive = "lsd --goup-dirs first -Al --recursive";
			list-all-recursive-long = "lsd --goup-dirs first -Al --recursive";
			list-long-recursive-all = "lsd --goup-dirs first -Al --recursive";
			list-long-all-recursive = "lsd --goup-dirs first -Al --recursive";
			list-recursive-long-all = "lsd --goup-dirs first -Al --recursive";
			list-recursive-all-long = "lsd --goup-dirs first -Al --recursive";
		};
	};

}
