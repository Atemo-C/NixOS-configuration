{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [

		# Aspell dictionaries
		aspell
		aspellDicts.uk
		aspellDicts.fr
		aspellDicts.en
		aspellDicts.eo

		# Hunspell dictionaries
		hunspell
		hunspellDicts.en_GB-ize
		hunspellDicts.en_US
		hunspellDicts.fr-any
	];

}
