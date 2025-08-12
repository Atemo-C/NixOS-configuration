# Commands to run in interactive sessions can go here.
if status is-interactive
end

# Remove the greetings message.
set fish_greeting

# Function mo make `!!` work as our lord and saviour the Linux Fox intended.
function last_history_item; echo $history[1]; end
abbr -a !! --position anywhere --function last_history_item