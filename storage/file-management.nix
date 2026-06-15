{ config, lib, pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		# Simple, fast and user-friendly alternative to find.
		fd

		# Tool to get/set ATA/SATA drive parameters under Linux.
		hdparm

		# UDisks2 graphical front-end.
		gnome-disk-utility

		# Next-gen `ls` command.
		lsd

		# Disk usage analyzer with an ncurses interface.
		ncdu

		# Disc burner and project creator for Xfce.
		xfburn

		# Archiving-only formats support and utilities.
		binutils   # ar
		libarchive # libarchive

		# Compression-only formats support and utilities.
		bzip3 # bzip3
		lz4   # LZ4
		lzip  # lzip
		lzop  # lzop

		# Archiving and compression formats support and utilities.
		p7zip # gzip bzip2 LZMA xz zstd ZIP RAR 7z CAB
		dar   # DAR
		tarlz # tarlz
		unar  # unarchiver
		lhasa # LHa
		unzip # zip

		# General archiving utilities.
		dtrx        # Do The Right Extraction: A tool for taking the hassle out of extracting archives.
		file-roller # Archive manager for GNOME.

		# Thumbnailing utilities and media and font formats support.
		ffmpegthumbnailer         # General video files thumbnailing
		freetype                  # Font files
		gnome-epub-thumbnailer    # .epub .mobi
		icoextract                # Windows .ico files
		kdePackages.kimageformats # Various image formats
		kdePackages.qtsvg         # .svg
		libgsf                    # .odf
		nufraw-thumbnailer        # .raw
		poppler                   # .pdf
		webp-pixbuf-loader        # .webp

		# Packages providing support and tools for additional filesystems.
		e2fsprogs
		exfatprogs
		f2fs-tools
		hfsprogs
		jfsutils
		nilfs-utils
		udftools
		xfsdump
		xfsprogs

		# Thumbnailing for Krita within Thunar.
		# https://github.com/NixOS/nixpkgs/issues/287003
		(pkgs.writeTextFile {
			name = "krita-thumbnails";
			text = ''
				[Thumbnailer Entry]
				TryExec=unzip
				Exec=sh -c "${pkgs.unzip}/bin/unzip -p %i preview.png > %o"
				MimeType=application/x-krita;
			'';
			destination = "/share/thumbnailers/kra.thumbnailer";
	})

		# Thumbnailing for audio files within Thunar.
		(pkgs.writeTextFile {
			name = "audio-thumbnails";
			text = ''
				[Thumbnailer Entry]
				TryExec=ffmpeg
				Exec=sh -c "${pkgs.ffmpeg-full}/bin/ffmpeg -y -i %i %o -fs %s"
				MimeType=audio/mpeg
			'';
			destination = "/share/thumbnailers/ffmpegaudio.thumbnailer";
		})
	];

	programs = {
		thunar = {
			# Whether to enable the Thunar file manager.
			enable = true;

			# Thunar plugins to install.
			plugins = with pkgs; [
				# Thunar plugin providing support for Subversion and Git.
				thunar-vcs-plugin

				# Thunar plugin providing file context menus for archives.
				thunar-archive-plugin

				# Thunar plugin providing quick folder sharing using Samba without requiring root access.
				thunar-shares-plugin

				# Thunar plugin providing tagging and renaming features for media files.
				thunar-media-tags-plugin
			];
		};

		# Whether to enable Xfconf, the Xfce configuration storage system.
		xfconf.enable = lib.mkIf config.programs.thunar.enable true;

		fish.shellAbbrs = lib.mkIf (lib.elem pkgs.lsd config.environment.systemPackages) rec {
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

	services = lib.mkIf config.programs.thunar.enable {
		# Whether to enable periodic scrubbing on BTRFS.
		btrfs.autoScrub.enable = true;

		# Whether to enable periodic SSD TRIM.
		# This may not be necessary on filesystems with a similar function enabled.
		fstrim.enable = true;

		# Whether to enable the GVfs userspace virtual filesystem.
		gvfs.enable = true;

		samba = {
			# Whether to enable Samba, the SMB/CIFS protocol.
			enable = true;

			# Which Samba package to use.
			package = pkgs.samba4Full;

			# Whether to enable user-configurable Samba shares.
			usershares.enable = true;

			# Whether to enable opening the default ports in the firewall for Samba.
			openFirewall = true;
		};

		samba-wsdd = {
			# Whether to enable Web Services Dynamic Discovery host daemon.
			# This enables (Samba) hosts, like your local NAS device,
			# to be found by Web Service Discovery Clients like Windows.
			enable = true;

			# Whether to open the required firewall ports in the firewall.
			openFirewall = true;
		};

		# Whether to enable the smartd daemon from the smartmontools package.
		smartd.enable = true;

		# Whether to enable Tumbler, A D-Bus thumbnailer service.
		tumbler.enable = true;

		# Whether to enable the udisks2 DBus service,
		# allowing programs to query and manipulate storage devices.
		udisks2.enable = true;
	};

	# Add the user to the `samba` group.
	users.users.${config.user.name}.extraGroups = lib.optional config.services.samba.enable "samba";

	# Link file management and other related files to the user's home directory.
	systemd.user.tmpfiles.users.${config.user.name}.rules = lib.concatLists [
		# Default programs to start when opening a file.
		[ "L %h/.config/mimeapps.list - - - - /etc/nixos/storage/files/mimeapps.list" ]

		# LSD configuration file.
		(lib.optional (lib.elem pkgs.lsd config.environment.systemPackages)
		"L %h/.config/lsd/config.yaml - - - - /etc/nixos/storage/files/lsd.yaml")

		# Custom actions for Thunar.
		(lib.optional config.programs.thunar.enable
		"L %h/.config/Thunar/uca.xml - - - - /etc/nixos/storage/files/thunar-custom-actions.xml")
	];
}