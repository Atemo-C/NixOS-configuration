# Install cmd-polkit, a tool that allows to easily customize the UI used to authenticate on Polkit.
# Required by `/etc/nixos/desktop/files/scripts/cmd-polkit.sh`.
{ ... }: { environment.systemPackages = [ pkgs.cmd-polkit ]; }