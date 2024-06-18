{ config, pkgs, ... }: {

	# The user's shell.
	# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.shell
	users.users.${config.Custom.Name}.shell = pkgs.fish;

	programs.fish = {

		# Enabling the user's shell.
		# https://search.nixos.org/options?channel=24.05&show=programs.fish.enable
		enable = true;

		# Shell abbreviations (not to be confused with aliases).
		# https://search.nixos.org/options?channel=24.05&show=programs.fish.shellAbbrs
		shellAbbrs = {

			# Short abbreviations.
			c = "clear";
			f = "fastfetch";
			h = "Hyprland";
			m = "micro";
			x = "exit";

			# NixOS abreviations.
			clean = "sudo nix-collect-garbade -d";
			update-boot = "sudo nixos-rebuild boot";
			update-now = "sudo nixos-rebuild switch";
			upgrade-boot = "sudo nixos-rebuild boot --upgrade";
			upgrade-now = "sudo nixos-rebuild switch --upgrade";

			# Online music abbreviations.
			lofi-escape = ''mpv --no-video "https://www.youtube.com/watch?v=S_MOd40zlYU"'';
			lofi-piano = ''mpv --no-video "https://www.youtube.com/watch?v=nWjC1RnLYbM"'';
			lofi-sleep = ''mpv --no-video "https://www.youtube.com/watch?v=rUxyKA_-grg"'';
			lofi-study = ''mpv --no-video "https://www.youtube.com/watch?v=jfKfPfyJRdk"'';
			lofi-synthwave = ''mpv --no-video "https://www.youtube.com/watch?v=4xDzrJKXOOY"'';
			nightinthewoods = ''mpv --no-video "https://www.youtube.com/watch?v=AsLKfqA73uE"'';
			tunic = ''mpv --no-video "https://www.youtube.com/watch?v=gzWd5hjcaPo"'';

			# YT-DLP abbreviations.
			yt = ''yt-dlp ""'';
			ytmp3 = ''yt-dlp -x --audio-format mp3 --audio-quality 0 ""'';

			# Lossless image conversion to JPEG XL inside a directory.
			jpg-jxl= "parallel -j 4 cjxl '{}' '{.}.jxl' -e 9 ::: *.jpg";
			jpeg-jxl= "parallel -j 4 cjxl '{}' '{.}.jxl' -e 9 ::: *.jpeg";
			png-jxl= "parallel -j 4 cjxl '{}' '{.}.jxl' -e 9 -d 0 ::: *.png";
			webp-jxl= "parallel -j 4 cjxl '{}' '{.}.jxl' -e 9 -d 0 ::: *.webp";
			avif-jxl= "parallel -j 4 cjxl '{}' '{.}.jxl' -e 9 -d 0 ::: *.avif";

			# [List] abbreviations.
			l = "lsd --group-dirs first";
			list = "lsd --group-dirs first";

			# [List all] abbreviations.
			la = "lsd --group-dirs first -A";
			list-all = "lsd --group-dirs first -A";

			# [List long] abbreviations.
			ll = "lsd --group-dirs first -l";
			list-long = "lsd --group-dirs first -l";

			# [List tree] abbreviations.
			lt = "lsd --group-dirs first --tree";
			list-tree = "lsd --group-dirs first --tree";

			# [List recursive] abbreviations.
			lr = "lsd --group-dirs first --recursive";
			list-recursive = "lsd --group-dirs first --recursive";

			# [List all+long] abbreviations.
			lal = "lsd --group-dirs first -Al";
			lla = "lsd --group-dirs first -Al";
			list-all-long = "lsd --group-dirs first -Al";
			list-long-all = "lsd --group-dirs first -Al";

			# [List all+tree] abbreviations.
			lat = "lsd --group-dirs first -A --tree";
			lta = "lsd --group-dirs first -A --tree";
			list-all-tree = "lsd --group-dirs first -A --tree";
			list-tree-all = "lsd --group-dirs first -A --tree";

			# [List all+recursive] abbreviations.
			lar = "lsd --group-dirs first -A --recursive";
			lra = "lsd --group-dirs first -A --recursive";
			list-all-recursive = "lsd --group-dirs first -A --recursive";
			list-recursive-all = "lsd --group-dirs first -A --recursive";

			# [List long+tree] abbreviations.
			llt = "lsd --group-dirs first -l --tree";
			ltl = "lsd --group-dirs first -l --tree";
			list-long-tree = "lsd --group-dirs first -l --tree";
			list-tree-long = "lsd --group-dirs first -l --tree";

			# [List long+recursive] abbreviations.
			llr = "lsd --group-dirs first -l --recursive";
			lrl = "lsd --group-dirs first -l --recursive";
			list-long-recursive = "lsd --group-dirs first -l --recursive";
			list-recursive-long = "lsd --group-dirs first -l --recursive";

			# [List all+long+tree]
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

			# [List all+long+recursive]
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
