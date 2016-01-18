#!/bin/bash

set -e
set -u

cat <<'EOF' >> /usr/share/X11/xkb/symbols/ctrl

// swap left alt and left ctrl
partial modifier_keys
xkb_symbols "swap_lalt_lctrl" {
    replace key <CAPS> { [ Control_L, Control_L ] };
    replace key <LALT> { [ Super_L, Super_L ] };
    replace key <RALT> { [ Control_R, Control_R ] };
    replace key <LCTL> { [ Alt_L, Meta_L  ] };
    replace key <RCTL> { [ Alt_R, Meta_R  ] };
    modifier_map  Control { <CAPS>, <RALT> };
    modifier_map Mod1 { <LCTL>, <RCTL> };
};
EOF

sed -i '/ctrl:ralt_rctrl/a \ \ ctrl:swap_lalt_lctrl\t=\t+ctrl(swap_lalt_lctrl)' /usr/share/X11/xkb/rules/evdev
sed -i '/ctrl:ctrl_ralt/a \ \ ctrl:swap_lalt_lctrl Swap left Ctrl and Alt' /usr/share/X11/xkb/rules/evdev.lst

cat <<'EOF' > /usr/share/X11/xorg.conf.d/10-keyboard.conf
Section "InputClass"
    Identifier "system-keyboard"
    MatchIsKeyboard "on"
    Option "XkbLayout" "us"
    Option "XkbOptions" "ctrl:swap_lalt_lctrl,shift:both_capslock"
EndSection
EOF

