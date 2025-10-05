{ config, lib, pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		# Archiving-only formats support and utilities.
		binutils   # ar
		cpio       # cpio
		libarchive # libarchive
		gnutar     # GNU tar

		# Compression-only formats support and utilities.
		bzip3 # bzip3
		gzip  # gzip
		lrzip # lrzip
		lz4   # LZ4
		lzip  # lzip
		lzop  # lzop

		# Archiving and compression formats support and utilities.
		p7zip     # gzip bzip2 LZMA xz zstd ZIP RAR 7z CAB
		dar       # DAR
		tarlz     # tarlz
		unar      # unarchiver
		lhasa lha # LHa
		unzip     # zip

		dtrx # Do The Right Extraction: A tool for taking the hassle out of extracting archives.

		# Disk and storage utilities.
		hdparm # A tool to get/set ATA/SATA drive parameters under Linux.
		ncdu   # Disk usage analyzer with an ncurses interface

		# Desktop and file utilities.
		desktop-file-utils # Command line utilities for working with .desktop files.
		shared-mime-info   # A database of common MIME types.

		# CD/DVD utilities.
		cdparanoia     # A tool and library for reading digital audio from CDs.
		cdrdao         # A tool for recording audio or data CD-Rs in disk-at-once (DAO) mode.
		cdrtools       # Highly portable CD/DVD/BluRay command line recording software.
		dvdplusrwtools # Tools for mastering Blu-ray and DVD+-RW/+-R media.
		vcdimager      # https://www.gnu.org/software/vcdimager/

		# Graphical programs.
	] ++ lib.optionals config.programs.niri.enable (with pkgs; [
		gparted              # Graphical disk partitioning tool.
		timeshift xorg.xhost # System restore tool for Linux. (As well as a dependency for it.)
		xfce.xfburn          # Disc burner and project creator for Xfce.

		# Thumbnailing utilties and media formats support.
	]) ++ lib.optionals config.programs.thunar.enable (with pkgs; [
		poppler                   # .pdf
		f3d                       # General 3D files thumbnailing
		ffmpegthumbnailer         # General video files thumbnailing
		freetype                  # Font files
		gnome-epub-thumbnailer    # .epub .mobi
		kdePackages.kimageformats # Various image formats
		kdePackages.qtsvg         # .svg
		libgsf                    # .odf
		mcomix                    # .cbr
		nufraw-thumbnailer        # .raw
		webp-pixbuf-loader        # .webp

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
	]);

	programs = {
		# Whether to enable File Roller, an archive manager for GNOME.
		file-roller.enable = true;

		# Whether to enable GNOME Disks daemon, a program designed to be a UDisks2 graphical front-end.
		gnome-disks.enable = true;
	};

	# Whether to enable the image thumbnailer for the Thunar file manager.
	services.tumbler.enable = lib.mkIf config.programs.thunar.enable true;
}