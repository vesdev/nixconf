#!/usr/bin/env bash
is_muted() {
    mic_name=$(pactl get-default-source)

    pactl list sources | \
        awk -v mic_name="${mic_name}" '{
            if ($0 ~ "Name: " mic_name) {
                matched_mic_name = 1;
            } else if (matched_mic_name && /Mute/) {
                print $2;
                exit;
            }
        }'
}

status() {
    MUTED="$(is_muted)"
    
    if [ "$MUTED" = "yes" ]; then
        echo ""
    else
        echo ""
    fi
}

listen() {
    status

    LANG=EN; pactl subscribe | while read -r event; do
        if echo "$event" | grep -q "source" || echo "$event" | grep -q "server"; then
            status
        fi
    done
}

toggle() {
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
}

case "$1" in
    --toggle)
        toggle
        ;;
    *)
        listen
        ;;
esac
