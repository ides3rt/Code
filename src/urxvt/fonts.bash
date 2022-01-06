#!/usr/bin/env bash

# It's slower than the one with sh(1) one, but It got written in pure bash(1)
# without any external program, unlike the one with sh(1) which required sed(1).
# Just proof of concept, I guess.

File="${XDG_CONFIG_HOME:-$HOME/.config}"/X11/Xresources
Content=$(< "$File")

while read Font; do
	[[ "$Font" == 'URxvt*.font:'* ]] && break
done < "$File"

case "$Font" in
	*'15.5'*)
		while read; do
			printf '%s\n' "${REPLY/15.5/30.5}"
		done <<< "$Content" > "$File" ;;
	*'30.5'*)
		while read; do
			printf '%s\n' "${REPLY/30.5/15.5}"
		done <<< "$Content" > "$File" ;;
esac

xrdb "$File"
