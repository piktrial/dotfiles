home.file.".local/bin/toggle-dzen.sh" = {
	text = ''
		#!/usr/bin/env bash
		PID_FILE="/tmp/dzen2.pid"

		if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
				kill "$(cat "$PID_FILE")" && rm "$PID_FILE"
		else
				dzen2 -dock -x '0' -y '0' -h '24' -w '1719' -ta 'l' -fg '#ffffff' -bg '#000000' &
				echo $! > "$PID_FILE"
		fi
	'';
	executable = true;
};

