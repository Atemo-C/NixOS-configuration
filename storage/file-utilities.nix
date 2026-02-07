{ config, lib, pkgs, ... }: {
	programs = {
		# Archiving-only formats support and utilities.
		binutils.install = true; # ar
		libarchive.install = true; # libarchive

		# Compression-only formats support and utilities.
		bzip3.install = true; # bzip3
		lz4.install = true; # LZ4
		lzip.install = true; # lzip
		lzop.install = true; # lzop

		# Archiving and compression formats support and utilities.
		p7zip.install = true; # gzip bzip2 LZMA xz zstd ZIP RAR 7z CAB
		dar.install = true; # DAR
		tarlz.install = true; # tarlz
		unar.install = true; # unarchiver
		lhasa.install = true; # LHa
		lha.install = true; # LHa
		unzip.install = true; # zip

		# General archiving utilities.
		dtrx.install = true; # Do The Right Extraction: A tool for taking the hassle out of extracting archives.
		file-roller.install = true; # Archive manager for GNOME

		# Disk and storage utilities.
		gparted.install = true; # Graphical disk partitioning tool.
		gnome-disks.enable = true; # UDisks2 graphical front-end
		hdparm.install = true; # A tool to get/set ATA/SATA drive parameters under Linux.
		ncdu.install = true; # Disk usage analyzer with an ncurses interface

		# Desktop and file utilities
		desktop-file-utils.install = true;

		# Thumbnailing utilities and media and font formats support.
		ffmpegthumbnailer.install = true; # General video files thumbnailing
		freetype.install = true; # Font files
		gnome-epub-thumbnailer.install = true; # .epub .mobi
		icoextract.install = true; # Windows .ico files
		kimageformats.install = true; # Various image formats
		qtsvg.enable = true; # .svg
		libgsf.install = true; # .odf
		nufraw-thumbnailer.install = true; # .raw
		poppler.install = true; # .pdf
		webp-pixbuf-loader.install = true; # .webp

		# Other programs.
		xfburn.enable = true;
	};

	environment.systemPackages = with pkgs; [
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

	# Whether to enable the image thumbnailer for the Thunar file manager.
	services.tumbler.enable = lib.mkIf config.programs.thunar.enable true;
}