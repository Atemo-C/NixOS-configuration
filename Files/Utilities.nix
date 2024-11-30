# Documentation:
#───────────────
# • https://wiki.archlinux.org/title/Archiving_and_compression
# • https://wiki.archlinux.org/title/Thunar
# • https://wiki.nixos.org/wiki/Thumbnails
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.11&show=services.gvfs.enable
# • https://search.nixos.org/options?channel=24.11&show=services.tumbler.enable
#
# Used NixOS packages:
#─────────────────────
# • [binutils]
#   https://www.gnu.org/software/binutils/
#
# • [cpio]
#   https://www.gnu.org/software/cpio/
#
# • [libarchive]
#   http://libarchive.org/
#
# • [gnutar]
#   https://www.gnu.org/software/tar/
#
# • [bzip3]
#   https://github.com/kspalaiologos/bzip3
#
# • [gzip]
#   https://www.gnu.org/software/gzip/
#
# • [lrzip]
#   http://ck.kolivas.org/apps/lrzip/
#
# • [lz4]
#   https://lz4.github.io/lz4/
#
# • [lzip]
#   https://www.nongnu.org/lzip/lzip.html
#
# • [lzop]
#   http://www.lzop.org/
#
# • [p7zip]
#   https://github.com/p7zip-project/p7zip
#
# • [dar]
#   http://dar.linux.free.fr/
#
# • [tarlz]
#   https://www.nongnu.org/lzip/tarlz.html
#
# • [unar]
#   https://theunarchiver.com/
#
# • [lhasa] [lha]
#   http://fragglet.github.io/lhasa
#
# • [file-roller]
#   https://gitlab.gnome.org/GNOME/file-roller
#
# • [dtrx]
#   https://github.com/dtrx-py/dtrx
#
# • [gnome-disk-utility]
#   https://apps.gnome.org/DiskUtility/
#
# • [gparted]
#   https://gparted.org/
#
# • [hdparm]
#   https://sourceforge.net/projects/hdparm/
#
# • [ncdu]
#   https://dev.yorhel.nl/ncdu
#
# • [ventoy-full]
#   https://www.ventoy.net/
#
# • [poppler]
#   https://poppler.freedesktop.org/
#
# • [f3d]
#   https://f3d-app.github.io/f3d
#
# • [ffmpegthumbnailer]
#   https://github.com/dirkvdb/ffmpegthumbnailer
#
# • [freetype]
#   https://www.freetype.org/
#
# • [gnome-epub-thumbnailer]
#   https://gitlab.gnome.org/GNOME/gnome-epub-thumbnailer
#
# • [kimageformats]
#   https://invent.kde.org/frameworks/kimageformats
#
# • [qtsvg]
#   https://www.qt.io/
#
# • [libgsf]
#   https://www.gnome.org/projects/libgsf
#
# • [mcomix]
#   https://sourceforge.net/projects/mcomix/
#
# • [nufraw-thumbnailer]
#   https://nufraw.sourceforge.io/
#
# • [tumbler]
#   https://gitlab.xfce.org/xfce/tumbler
#
# • [webp-pixbuf-loader]
#   https://github.com/aruiz/webp-pixbuf-loader
#
# • [desktop-file-utils]
#   https://www.freedesktop.org/wiki/Software/desktop-file-utils
#
# • [shared-mime-info]
#   http://freedesktop.org/wiki/Software/shared-mime-info

{ pkgs, ... }: {

	environment.systemPackages = [
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

		# General archiving utilities.
		## Archive manager for the GNOME desktop environment.
		pkgs.gnome.file-roller

		## Do The Right Extraction: A tool for taking the hassle out of extracting archives.
		pkgs.dtrx

		# Disk utilities.
		## GNOME's disk utility.
		pkgs.gnome.gnome-disk-utility

		## Graphical disk partitioning tool.
		pkgs.gparted

		## A tool to get/set ATA/SATA drive parameters under Linux.
		pkgs.hdparm

		## Disk usage analyzer with an ncurses interface
		pkgs.ncdu

		## A new bootable USB solution.
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
		pkgs.xfce.tumbler              # General image files thumbnailing
		pkgs.webp-pixbuf-loader        # .webp

		# Other utilities.
		## Command line utilities for working with .desktop files.
		pkgs.desktop-file-utils

		## A database of common MIME types.
		pkgs.shared-mime-info
	];

	services = {
		# Whether to enable GVfs.
		gvfs.enable = true;

		# Whether to enable the Tumbler D-Bus thumbnailer service.
		tumbler.enable = true;
	};
}
