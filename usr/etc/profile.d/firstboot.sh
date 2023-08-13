#!/usr/bin/env sh
#
if test "$(id -u)" -gt "0" && test -d "$HOME" && test ! -e "$HOME/.config/.bootstrap-done"; then
    echo "exec foot -e yadm clone https://github.com/elken/.files" >"$HOME/.config/sway/config.d/99-firstboot.conf"
fi
