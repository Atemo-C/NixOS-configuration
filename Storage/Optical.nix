# Used NixOS packages:
#─────────────────────
# • [xfburn]
#   https://gitlab.xfce.org/apps/xfburn
#
# • [cdparanoia]
#   https://xiph.org/paranoia
#
# • [cdrdao]
#   https://cdrdao.sourceforge.net/
#
# • [cdrtools]
#   https://cdrtools.sourceforge.net/private/cdrecord.html
#
# • [dvdplusrwtools]
#   http://fy.chalmers.se/~appro/linux/DVD+RW/tools
#
# • [transcode]
#   http://www.transcoding.org/
#
# • [vcdimager]
#   https://www.gnu.org/software/vcdimager/

{ pkgs, ... }: { environment.systemPackages = [

	# Disc burner and project creator for Xfce.
	pkgs.xfce.xfburn

	# Collection of optical media utilities and optional depedencies for xfburn.
	## A tool and library for reading digital audio from CDs.
	pkgs.cdparanoia

	## A tool for recording audio or data CD-Rs in disk-at-once (DAO) mode.
	pkgs.cdrdao

	## Highly portable CD/DVD/BluRay command line recording software.
	pkgs.cdrtools

	## Tools for mastering Blu-ray and DVD+-RW/+-R media
	pkgs.dvdplusrwtools

	## http://www.transcoding.org/
	pkgs.transcode

	## https://www.gnu.org/software/vcdimager/
	pkgs.vcdimager

]; }
