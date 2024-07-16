{ config, pkgs, ... }: {

	# Micro text editor (all users).
	programs.micro = {
		# Whether to enable the Micro text editor.
		# https://search.nixos.org/options?channel=24.05&show=programs.micro.enable
		enable = true;

		# Keyboard and mouse bindings.
		# https://search.nixos.org/options?channel=24.05&show=programs.micro.bindings
		bindings = [
			# Plugins
			"Alt-/" = "lua:comment.comment"
			"CtrlUnderscore" = "lua:comment.comment"
			"F5" = "lua:wc.wordCount"

			# Cursor movement
			"Left" = "CursorLeft"
			"Down" = "CursorDown"
			"Up" = "CursorUp"
			"Right" = "CursorRight"
			"PageUp" = "CursorPageUp"
			"PageDown" = "CursorPageDown"
			"Ctrl-Down" = "CursorEnd"
			"Ctrl-Up" = "CursorStart"
			"Ctrl-Home" = "CursorStart"
			"Ctrl-End" = "CursorEnd"
			"Alt-Left" = "StartOfTextToggle"
			"Alt-Right" = "EndOfLine"
			"Home" = "StartOfText"
			"End" = "EndOfLine"
			"Alt-{" = "ParagraphPrevious"
			"Alt-}" = "ParagraphNext"
			"Alt-[" = "DiffPrevious|CursorStart"
			"Alt-]" = "DiffNext|CursorEnd"

			# Text selection
			"Shift-Left" = "SelectLeft"
			"Shift-Down" = "SelectDown"
			"Shift-Up" = "SelectUp"
			"Shift-Right" = "SelectRight"
			"Shift-Alt-Left" = "SelectToStartOfTextToggle"
			"Shift-Home" = "SelectToStartOfTextToggle"
			"Shift-Alt-Right" = "SelectToEndOfLine"
			"Shift-End" = "SelectToEndOfLine"
			"Ctrl-Shift-Up" = "SelectToStart"
			"Ctrl-Shift-Down" = "SelectToEnd"
			"Ctrl-A" = "SelectAll"

			# Word selection
			"Ctrl-Shift-Left" = "SelectWordLeft"
			"Ctrl-Shift-Right" = "SelectWordRight"

			# Line movement
			"Alt-Down" = "MoveLinesDown"
			"Alt-Up" = "MoveLinesUp"

			# General actions
			"Backspace" = "Backspace"
			"Delete" = "Delete"
			"Alt-Backspace" = "DeleteWordLeft"
			"Enter" = "InsertNewline"
			"Tab" = "Autocomplete|IndentSelection|InsertTab"
			"Backtab" = "OutdentSelection|OutdentLine"
			"Esc" = "Escape"
			"Insert" = "ToggleOverwriteMode"

			# Help
			"Alt-h" = "ToggleHelp"
			"Alt-g" = "ToggleKeyMenu"

			# Shell and Command
			"Alt-s" = "ShellMode"
			"Ctrl-e" = "CommandMode"

			# Ruler
			"Ctrl-r" = "ToggleRuler"

			# Find and go
			"Ctrl-f" = "Find"
			"Ctrl-n" = "FindNext"
			"Ctrl-p" = "FindPrevious"
			"Alt-f" = "FindLiteral"
			"Ctrl-g" = "command-edit=goto"

			# Quit
			"Ctrl-q" = "Quit"

			# Splits
			"Ctrl-w" = "NextSplit"

			# On-the-fly macros
			"Ctrl-u" = "ToggleMacro"
			"Ctrl-j" = "PlayMacro"

			# Multi-cursor
			"Alt-n" = "SpawnMultiCursor"
			"AltShiftUp" = "SpawnMultiCursorUp"
			"AltShiftDown" = "SpawnMultiCursorDown"
			"Alt-m" = "SpawnMultiCursorSelect"
			"Alt-p" = "RemoveMultiCursor"
			"Alt-c" = "RemoveAllMultiCursors"
			"Alt-x" = "SkipMultiCursor"

			# Text control
			"Ctrl-z" = "Undo"
			"Ctrl-y" = "Redo"
			"Ctrl-c" = "CopyLine|Copy"
			"Ctrl-v" = "Paste"
			"Ctrl-x" = "Cut"
			"Ctrl-k" = "CutLine"
			"Ctrl-d" = "DuplicateLine"

			# File control
			"Ctrl-o" = "OpenFile"
			"Ctrl-s" = "Save"

			# Tab control
			"Ctrl-t" = "AddTab"
			"Alt-Tab" = "NextTab"
			"Alt-Backtab" = "PreviousTab"

			# Mouse tab control
			"Ctrl-MouseWheelUp" = "NextTab"
			"Ctrl-MouseWheelDown" = "PreviousTab"

			# Mouse bindings
			"MouseWheelUp" = "ScrollUp"
			"MouseWheelDown" = "ScrollDown"
			"MouseLeft" = "MousePress"
			"MouseMiddle" = "PastePrimary"
			"Ctrl-MouseLeft" = "MouseMultiCursor"
		];

		# Custom Micro colorschemes written to XDG_CONFIG_HOME/micro/colorschemes/<name>.micro.
		# https://search.nixos.org/options?channel=24.05&show=programs.micro.colorschemes
		colorschemes.Atemos-colours = {
			comment = "brightblue";
			statement = "yellow";
			preproc = "bold cyan";
			special = "brightmagenta";
			ignore = "default";
			error = "bold red";
			todo = "underline black,bright yellow";
			hlsearch = "white,darkgreen";
			indent-char = ",brightgreen";
			statusline = "white,black";
			tabbar = "yellow,black";
			color-column = "brightblack";
			underlined.url = "underline blue,white";
			match-brace = ",magenta";
			tab-error = "brightred";
			trailingws = "brightred";
			divider = "blue";
			constant = "cyan";
			constant.bool = "bold cyan";
			constant.bool.true = "bold green";
			constant.bool.false = "bold red";
			constant.bool.string = "yellow";
			constant.string.url = "underline blue";
			constant.number = "bold magenta";
			constant.specialChar = "bold magenta";
			identifier = "magenta";
			identifier.macro = "identifier";
			identifier.var = "blue";
			identifier.class = "bold white";
			symbol = "bold, brightred";
			symbol.brackets = "bold brightcyan";
			symbol.tag = "bold brightred";
			symbol.tag.extended = "bold green";
			type = "green";
			type.keyword = "bold green";
			line-number = "blue,black";
			current-line-number = "cyan,black,bold";
			diff-added = "bold green";
			diff-modified = "bold yellow";
			diff-deleted = "bold red";
			gutter-error = ",red";
			gutter-warning = "red";
		};

		# Which plugins to install with Micro.
		# https://search.nixos.org/options?channel=24.05&show=programs.micro.plugins
		plugins = with pkgs.micro-plugins; [ wc ];

		# Settings written to XDG_CONFIG_HOME/micro/settings.json.
		# https://search.nixos.org/options?channel=24.05&show=programs.micro.settings
		settings = {
			"*.conf" = { filetype = "shell"; };
			"*.dirs" = { filetype = "shell"; };
			"*.jsonc" = { filetype = "json"; };
			"*.sav" = { filetype = "nix"; };
		    "colorcolumn" = 120;
		    "colorscheme" = "Atemos-colours";
		    "relativeruler" = true;
		    "rmtrailingws" = true;
		    "softwrap" = true;
		    "tabhighlight" = true;
		    "wordwrap" = true;
		};
	};

};
