{ config, pkgs, ... }: { environment.systemPackages = [

	# Archiving-only formats support and utilities.
	pkgs.binutils   # ar
	pkgs.cpio       # cpio
	pkgs.libarchive # libarchive
	pkgs.gnutar     # GNU tar

	# Compression-only formats support and utilities.
	pkgs.bzip3 # bzip3
	pkgs.gzip  # gzip
	pkgs.lrzip # lrzip
	pkgs.lz4   # LZ4
	pkgs.lzip  # lzip
	pkgs.lzop  # lzop

	# Archiving and compression formats support and utilities.
	pkgs.p7zip          # gzip bzip2 LZMA xz zstd ZIP RAR 7z CAB
	pkgs.dar            # DAR
	pkgs.tarlz          # tarlz
	pkgs.unar           # unarchiver
	pkgs.lhasa pkgs.lha # LHa
	pkgs.unzip          # zip

	# Archive manager for the GNOME desktop environment.
	pkgs.file-roller

	# Do The Right Extraction: A tool for taking the hassle out of extracting archives.
	pkgs.dtrx

	# GNOME's disk utility.
	pkgs.gnome-disk-utility

	# Graphical disk partitioning tool.
	pkgs.gparted

	# A tool to get/set ATA/SATA drive parameters under Linux.
	pkgs.hdparm

	# Disk usage analyzer with an ncurses interface
	pkgs.ncdu

	# System restore tool for Linux. (As well as a dependency for it.)
	pkgs.timeshift pkgs.xorg.xhost

	# A new bootable USB solution.
	pkgs.ventoy-full

	# Thumbnailing utilties and media formats support.
	pkgs.poppler                   # .pdf
	pkgs.f3d                       # General 3D files thumbnailing
	pkgs.ffmpegthumbnailer         # General video files thumbnailing
	pkgs.freetype                  # Font files
	pkgs.gnome-epub-thumbnailer    # .epub .mobi
	pkgs.kdePackages.kimageformats # Various image formats
	pkgs.kdePackages.qtsvg         # .svg
	pkgs.libgsf                    # .odf
	pkgs.mcomix                    # .cbr
	pkgs.nufraw-thumbnailer        # .raw
	pkgs.webp-pixbuf-loader        # .webp

	# General image files thumbnailing for XFCE's Thunar.
	( if config.programs.thunar.enable then pkgs.xfce.tumbler else null )

	# Command line utilities for working with .desktop files.
	pkgs.desktop-file-utils

	# A database of common MIME types.
	pkgs.shared-mime-info

]; }
