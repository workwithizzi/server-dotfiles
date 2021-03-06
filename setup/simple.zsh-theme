# shellcheck shell=sh
# Yay! High voltage and arrows!

# red
# blue
# yellow
# white
# black

prompt_setup_pygmalion() {
	ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}|%{$fg[yellow]%}"
	ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
	ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡%{$reset_color%}"
	ZSH_THEME_GIT_PROMPT_CLEAN=""

	NEWLINE=$'\n'
	BARLINE="%{${fg[cyan]}%}╔══%n════════════════════════════════════════════%{$reset_color%}"
	ENDING="%{${fg[cyan]}%}╚ 🚀%{$reset_color%}"

	DIRECTORY_INFO="%{${fg[cyan]}%}╟ %{$reset_color%}%{${fg[magenta]}%}%0~%{$reset_color%}%{${fg[cyan]}%}%{$reset_color%}"

	base_prompt='$NEWLINE$BARLINE$NEWLINE$DIRECTORY_INFO'
	# post_prompt='%{$fg[cyan]%}⇒%{$reset_color%}  '
	post_prompt='$ENDING  '

	# PROMPT="firstline${NEWLINE}secondline "

	base_prompt_nocolor=$(echo "$base_prompt" | perl -pe "s/%\{[^}]+\}//g")
	post_prompt_nocolor=$(echo "$post_prompt" | perl -pe "s/%\{[^}]+\}//g")

	autoload -U add-zsh-hook
	add-zsh-hook precmd prompt_pygmalion_precmd
}

prompt_pygmalion_precmd() {
	local gitinfo=$(git_prompt_info)
	local gitinfo_nocolor=$(echo "$gitinfo" | perl -pe "s/%\{[^}]+\}//g")
	local exp_nocolor="$(print -P \"$base_prompt_nocolor$gitinfo_nocolor$post_prompt_nocolor\")"
	local prompt_length=${#exp_nocolor}

	local nl=""

	if [[ $prompt_length -gt 40 ]]; then
		nl=$'\n%{\r%}'
	fi
	PROMPT="$base_prompt$gitinfo$nl$post_prompt"
}

prompt_setup_pygmalion
