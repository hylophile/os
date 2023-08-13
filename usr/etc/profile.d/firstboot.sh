#!/usr/bin/env sh
#
if test "$(id -u)" -gt "0" && test -d "$HOME" && test ! -e "$HOME/.config/.bootstrap-done"; then
    foot -e zsh
fi
