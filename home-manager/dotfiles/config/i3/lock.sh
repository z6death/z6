#!/bin/bash

IMAGE="$HOME/img/z.png"

i3lock-color \
    --image="$IMAGE" \
    --clock \
    --indicator \
    --time-str="%H:%M" \
    --date-str="%A, %d %B %Y" \
    --radius=120 \
    --ring-width=8 \
    --veriftext="Verifying..." \
    --wrongtext="Wrong!" \
    --noinputtext="..." \
    --insidecolor=00000088 \
    --ringcolor=ffffffcc \
    --line-uses-inside \
    --keyhlcolor=00ff00cc \
    --bshlcolor=ff0000cc \
    --separatorcolor=00000000 \
    --insidevercolor=00000088 \
    --insidewrongcolor=00000088 \
    --ringvercolor=00ff00cc \
    --ringwrongcolor=ff0000cc \
    --timecolor=ffffffff \
    --datecolor=ffffffff \
    --layoutcolor=ffffffff \
    --greetertext="Type your password" \
    --greetercolor=ffffffff \
    --greeter-pos="x+0:h-200" \
    --time-pos="x+0:h-150" \
    --date-pos="x+0:h-110"

