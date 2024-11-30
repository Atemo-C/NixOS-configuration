# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Locales
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.11&show=i18n.defaultLocale
# • https://search.nixos.org/options?channel=24.11&show=i18n.extraLocaleSettings

{ config, ... }: { i18n = {

	# The default locale.
	# It determines the language for program messages, the format for dates and times, sort order, and so on.
	# It also determines the character set, such as UTF-8.
	defaultLocale = "en_US.UTF-8";

	# A set of additional system-wide locale settings other than LANG which is configured with i18n.defaultLocale.
	extraLocaleSettings = {
		LC_ADDRESS = "fr_FR.UTF-8";
		LC_IDENTIFICATION = "fr_FR.UTF-8";
		LC_MEASUREMENT = "fr_FR.UTF-8";
		LC_MONETARY = "fr_FR.UTF-8";
		LC_NAME = "fr_FR.UTF-8";
		LC_NUMERIC = "fr_FR.UTF-8";
		LC_PAPER = "fr_FR.UTF-8";
		LC_TELEPHONE = "fr_FR.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

}; }
