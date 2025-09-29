function open-controlcenter {
    exec env XDG_CURRENT_DESKTOP=GNOME gnome-control-center
}

function setup-input {
    # Keyboard input
	setxkbmap -model pc105 -layout us,ru -option grp:win_space_toggle

    # Mouse speed
    #xinput --set-prop 13 313 0.1
}

function disable-notebook-monitor {
    xrandr --output eDP-1 --off
}

function disable-hdmi-monitor {
    xrandr --output HDMI-1 --off
}

function enable-both-monitors {
    xrandr --output eDP-1 --auto
    xrandr --output HDMI-1 --auto --right-of eDP-1 --primary
}

function edit {
    ${EDITOR:-${VISUAL:-vi}} $@
}
