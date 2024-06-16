{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [ audacity ];

}
