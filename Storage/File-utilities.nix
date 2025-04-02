{ pkgs, ... }: { environment.systemPackages = with pkgs; [

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

	# Archive manager for the GNOME desktop environment.
	file-roller

	# Do The Right Extraction: A tool for taking the hassle out of extracting archives.
	dtrx

	# GNOME's disk utility.
	gnome-disk-utility

	# Graphical disk partitioning tool.
	gparted

	# A tool to get/set ATA/SATA drive parameters under Linux.
	hdparm

	# Disk usage analyzer with an ncurses interface
	ncdu

	# A new bootable USB solution.
	ventoy-full

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
	xfce.tumbler              # General image files thumbnailing
	webp-pixbuf-loader        # .webp

	# Other utilities.
	# Command line utilities for working with .desktop files.
	desktop-file-utils

	# A database of common MIME types.
	shared-mime-info

]; }
