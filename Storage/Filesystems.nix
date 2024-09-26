# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=boot.supportedFilesystems
#
# Used NixOS packages:
#─────────────────────
# • [cryptsetup]
#   https://gitlab.com/cryptsetup/cryptsetup/
#
# • [exfatprogs]
#   https://github.com/exfatprogs/exfatprogs
#
# • [f2fs-tools]
#   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/
#
# • [hfsprogs]
#   https://search.nixos.org/packages?channel=24.05&show=hfsprogs
#
# • [jfsutils]
#   https://jfs.sourceforge.net/
#
# • [lvm2]
#   http://sourceware.org/lvm2/
#
# • [nilfs-utils]
#   https://search.nixos.org/packages?channel=24.05&show=nilfs-utils
#
# • [reiser4progs]
#   https://sourceforge.net/projects/reiser4/
#
# • [udftools]
#   https://search.nixos.org/packages?channel=24.05&show=udftools
#
# • [util-linux]
#   https://www.kernel.org/pub/linux/utils/util-linux/
#
# • [xfsdump]
#   https://git.kernel.org/pub/scm/fs/xfs/xfsdump-dev.git/tree/doc/CHANGES
#
# • [xfsprogs]
#   https://xfs.wiki.kernel.org/

{ config, pkgs, ... }: {

	# Names of supported filesystem types, or an attribute set of file system types and their state.
	# The set form may be used together with lib.mkForce to explicitly disable support for specific filesystems;
	# e.g. to disable ZFS with an unsupported kernel.
	boot.supportedFilesystems = [ "ntfs" ];

	# Packages providing support for additional filesystems and related utilities.
	# (Gparted will be happy about that.)
	environment.systemPackages = [
		pkgs.cryptsetup
		pkgs.exfatprogs
		pkgs.f2fs-tools
		pkgs.hfsprogs
		pkgs.jfsutils
		pkgs.lvm2
		pkgs.nilfs-utils
		pkgs.reiser4progs
		pkgs.udftools
		pkgs.util-linux
		pkgs.xfsdump
		pkgs.xfsprogs
	];

}
