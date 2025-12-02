#!/run/current-system/sw/bin/dash

# Navigate to the $HOME directory.
cd "$HOME" || exit

# Show all files.
[ "$1" = "-h" ] || [ "$1" = "--hidden" ] && {
	while :
	do
		selected=$(find . -maxdepth 1 -mindepth 1 -printf '%P\n' 2>/dev/null | \
		fuzzel --anchor top-left --no-icons --width 50 --dmenu) || break
		# If a file, open it with whichever action is the default.
		# If a directory, open it with the default file manager.
		[ -z "$selected" ] && break
		[ -d "$selected" ] && $FILEMANAGER "$selected" && continue
		xdg-open "$selected" && break
	done
	exit
}

# Show only normal files.
while :
do
	selected=$(find . -maxdepth 1 -mindepth 1 ! -name '.*' -printf '%P\n' 2>/dev/null | sort | \
	fuzzel --anchor top-left --no-icons --width 50 --dmenu) || break
	# If a file, open it with whichever action is the default.
	# If a directory, open it with the default file manager.
	[ -z "$selected" ] && break
	[ -d "$selected" ] && $FILEMANAGER "$selected" & exit
	xdg-open "$selected" && break
done
exit