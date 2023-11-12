#  ┌─┐┌─┐┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐┬─┐┌─┐
#  │  │ ││││├─┘│  ├┤  │ ├┤ ├┬┘└─┐
#  └─┘└─┘┴ ┴┴  ┴─┘└─┘ ┴ └─┘┴└─└─┘

let carapace_completer = {|spans: list<string>|
	carapace $spans.0 nushell $spans | from json
	| default []
	| if ($in | filter {|x|
			($x.value | str ends-with 'ERR') and ($x.description =~ 'unknown (shorthand )?flag:')
	} | is-empty) { $in } else { null }
}

let fish_completer = {|spans: list<string>|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | $"value(char tab)description(char newline)" + $in
    | from tsv --flexible --no-infer
}

let zoxide_completer = {|spans: list<string>|
  $spans | skip 1 | zoxide query -l $in | lines | where {|x| $x != $env.PWD}
}

let git_completer = {|spans: list<string>|
	let aliases = (git config --get-regexp ^alias | lines | split column ' ' name command | update name {|x| $x.name | split row '.' | last })
	let spans_after_alias = ($spans | update 1 ($aliases | where name == $spans.1 | if ($in | is-empty) { $spans.1 } else { $in.0.command | split words }) | flatten)

	if ($spans_after_alias.1 in [checkout branch]) {
		do $fish_completer $spans_after_alias
	} else {
		do $carapace_completer $spans_after_alias
	}
}

let yadm_completer = {|spans|
	let add_aliases = (git config --get-regexp ^alias | lines | split column  ' ' name command | where command == "add" | get name | split column . _ alias | get alias)
	if $spans.1 in $add_aliases {
		do $git_completer ([git --git-dir (yadm introspect repo | str trim) --work-tree (pwd)] | append ($spans | drop nth 0))
	} else {
		do $git_completer $spans
	}
}

let default_completer = $carapace_completer
let fallback_completer = $fish_completer

let external_completer = {|spans|
		let has_alias = (scope aliases | where name == $spans.0)
		let spans = (if not ($has_alias | is-empty) {
			$spans | skip 1 | prepend ($has_alias | get expansion | split row ' ' | first)
		} else { $spans })

		match $spans.0 {
			__zoxide_z => $zoxide_completer
			__zoxide_zi => $zoxide_completer
			asdf => $fish_completer
			git => $git_completer
			gpg => $fish_completer
			nu => $fish_completer
			sd => $fish_completer
			yadm => $yadm_completer
			_ => $default_completer
		} | do $in $spans | if (($in | is-empty) and ($fallback_completer != null))) { do $fallback_completer $spans } else { $in }
}
