{ config, lib, pkgs, ... }: {
	# The path to the user's default shell.
	# The default system shell remains unchanged.
	users.users.${config.user.name}.shell = lib.mkIf config.programs.fish.enable "${pkgs.lib.getBin pkgs.fish}/bin/fish";

	programs.fish = {
		# Whether to enable the FISH shell.
		enable = true;

		# Disable FISH's greetings message.
		interactiveShellInit = ''set fish_greeting'';

		# Set of basic shell abbreviations.
		shellAbbrs = rec {
			# Short abbreviations.
			c = "clear";
			x = "exit";
			o = "open";

			# Finding text within files in a directory.
			fdtext = "grep -Rn -e";

			# Safer file copying.
			cp = "cp -v -i";
			copy = cp;

			# Safer directory copying.
			cpdir = "cp -r -v -i";
			copy-directory = cpdir;

			# Safer moving of files.
			mv = "mv -v -i";
			move = mv;

			# More verbose and safer file deletion.
			rm = "rm -v -i";
			remove = rm;

			# More verbose directory deletion.
			rmdir = "rm -d -r -v";
			remove-directory = rmdir;

			# Going back up more directories.
			"..." = "cd ../../";
			".3" = "cd ../../";
			"...." = "cd ../../../";
			".4" = "cd ../../../";
			"....." = "cd ../../../../";
			".5" = "cd ../../../../";
			"......" = "cd ../../../../../";
			".6" = "cd ../../../../../";
			"......." = "cd ../../../../../../";
			".7" = "cd ../../../../../../";
			"........" = "cd ../../../../../../../";
			".8" = "cd ../../../../../../../";
			"........." = "cd ../../../../../../../../";
			".9" = "cd ../../../../../../../../";
			".........." = "cd ../../../../../../../../../";
			".10" = "cd ../../../../../../../../../";

			# See what process systemd had to kill after the default timeout.
			killed = "journalctl -b-1 | grep killed";

			# Toggling recent files history.
			enable-recent-files = "run0 rm -v -i ~/.local/share/recently-used.xbel";
			disable-recent-files = "run0 rm -v -i ~/.local/share/recently-used.xbel; touch ~/.local/share/recently-used.xbel && run0 ${pkgs.lib.getBin pkgs.e2fsprogs}/bin/chattr -V +i ~/.local/share/recently-used.xbel";

			# Create a `.iso` file from a physical disc media.
			mkisofromdisc = "dd if=/dev/cdrom of=./CDROM.iso status=progress";

			# Creating a `.iso` file from a file or directory.
			mkisofromfile = "${pkgs.lib.getBin pkgs.cdrtools}/bin/mkisofs -lJR -o output.iso";
		};
	};
}