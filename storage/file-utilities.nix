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

		# Do The Right Extraction: A tool for taking the hassle out of extracting archives.
		dtrx

		# A tool to get/set ATA/SATA drive parameters under Linux.
		hdparm

		# Disk usage analyzer with an ncurses interface
		ncdu

		# Command line utilities for working with .desktop files.
		desktop-file-utils

		# A database of common MIME types.
		shared-mime-info

		# A tool and library for reading digital audio from CDs.
		cdparanoia

		# A tool for recording audio or data CD-Rs in disk-at-once (DAO) mode.
		cdrdao

		# Highly portable CD/DVD/BluRay command line recording software.
		cdrtools

		# Tools for mastering Blu-ray and DVD+-RW/+-R media.
		dvdplusrwtools

		# https://www.gnu.org/software/vcdimager/
		vcdimager
	] ++ lib.optionals config.programs.niri.enable (with pkgs; [
		# Archive manager for the GNOME desktop environment.
		file-roller

		# GNOME's disk utility.
		gnome-disk-utility

		# Graphical disk partitioning tool.
		gparted

		# System restore tool for Linux. (As well as a dependency for it.)
		timeshift xorg.xhost

		# Disc burner and project creator for Xfce.
		xfce.xfburn
	]) ++ lib.optionals config.programs.thunar.enable (with pkgs; [
		# Thumbnailing utilties and media formats support.
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
	]);

	# Whether to enable the image thumbnailer for the Thunar file manager.
	services.tumbler.enable = lib.mkIf config.programs.thunar.enable true;
}