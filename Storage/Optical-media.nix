{ pkgs, ... }: { environment.systemPackages = with pkgs; [

	# Disc burner and project creator for Xfce.
	xfce.xfburn

	# A tool and library for reading digital audio from CDs.
	cdparanoia

	# A tool for recording audio or data CD-Rs in disk-at-once (DAO) mode.
	cdrdao

	# Highly portable CD/DVD/BluRay command line recording software.
	cdrtools

	# Tools for mastering Blu-ray and DVD+-RW/+-R media
	dvdplusrwtools

	# https://www.gnu.org/software/vcdimager/
	vcdimager

]; }
