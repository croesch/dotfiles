#!/bin/bash

I3_CONFIG_FILE="$HOME/.i3/config"

CAT_LOCATION=$(which cat)
echo -n "Crafting .i3/config from base and .i3-env/config.."

# sourcing variables
. $HOME/.i3/config.base.variables

if [ -f "$HOME/.i3-env/config.variables" ]
then
  . $HOME/.i3-env/config.variables
fi

# crafting the file
printf "###############\n#\n# DO NOT EDIT THIS FILE - EDIT ~/.i3/config.base instead\n#\n###############\n" > "$I3_CONFIG_FILE"
echo "set \$mod ${I3_MODIFIER}" >> "$I3_CONFIG_FILE"
echo "set \$font ${I3_FONT}" >> "$I3_CONFIG_FILE"
echo "set \$dmenu ${I3_DMENU_CMD}" >> "$I3_CONFIG_FILE"
echo "set \$screenshooter_full ${I3_SCREENSHOOTER_FULL_CMD}" >> "$I3_CONFIG_FILE"
echo "set \$screenshooter_select ${I3_SCREENSHOOTER_SELECT_CMD}" >> "$I3_CONFIG_FILE"
$CAT_LOCATION "$HOME/.i3/config.base1" "$HOME/.i3-env/bar.config" "$HOME/.i3/config.base2" "$HOME/.i3-env/config" 2>/dev/null >> "$I3_CONFIG_FILE"

echo "done."

command -v i3-msg >/dev/null 2>&1 || { echo "i3 does not seem to be available."; exit; }
i3-msg "reload"
