#!/bin/zsh

TOKEN_FILE="/usr/share/astroarch_onboarding/configs/astromonitor_token.tmp"

if [ -f "$TOKEN_FILE" ]; then
    VALUE=$(cat "$TOKEN_FILE" | tr '[:upper:]' '[:lower:]')

    if [ "$VALUE" = "true" ]; then
	cd /home/astronaut
	konsole --workdir /home/astronaut -e zsh -c "astromonitor" &
    fi
fi
