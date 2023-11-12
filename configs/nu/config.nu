$env.config.show_banner = false
# $env.PROMPT_COMMAND_RIGHT = {($nu.startup-time)}

$env.config.completions = {
	external: {
    completer: $external_completer 
	}
}

$env.config.filesize = {
	metric: false # true => KB, false => KiB
	format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, auto
}

$env.config.cursor_shape = {  # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape
	emacs: blink_line	          # default => line 
	vi_insert: blink_underscore	# default => block
	vi_normal: blink_block      # default => underscore
}
