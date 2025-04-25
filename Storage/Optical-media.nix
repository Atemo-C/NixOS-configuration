{ pkgs, ... }: { environment.systemPackages = [

	# Disc burner and project creator for Xfce.
	pkgs.xfce.xfburn

	# A tool and library for reading digital audio from CDs.
	pkgs.cdparanoia

	# A tool for recording audio or data CD-Rs in disk-at-once (DAO) mode.
	pkgs.cdrdao

	# Highly portable CD/DVD/BluRay command line recording software.
	pkgs.cdrtools

	# Tools for mastering Blu-ray and DVD+-RW/+-R media
	pkgs.dvdplusrwtools

	# https://www.gnu.org/software/vcdimager/
	pkgs.vcdimager

]; }
