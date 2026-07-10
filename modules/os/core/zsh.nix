{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		fzf
		zsh-powerlevel10k
	];

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
		enableLsColors = true;
		
		shellAliases = {
			la = "ls -a";
			ll = "ls -l";
			l = "ls -al";
		};

		histSize = 1000;
		histFile = "$HOME/.zsh_history";

		interactiveShellInit = ''
			source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

			# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
			[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

			# Fastfetch will only execute when outside of TMUX
			if [[ "$TERM_PROGRAM" != "tmux" ]]; then
					fastfetch
			fi

			# fzf key bindings and fuzzy completion
			if command -v fzf >/dev/null 2>&1; then
				source <(fzf --zsh)
		  	fi

			export FZF_DEFAULT_OPTS="
				--height=80%
				--layout=reverse
				--border=rounded
				--preview='bat --style=numbers --color=always --line-range=:500 {}'
				--preview-window=right:60%:wrap
		  	"

			export FZF_CTRL_T_OPTS="
				--preview='bat --style=numbers --color=always --line-range=:500 {}'
				--preview-window=right:60%:wrap
			"

			# Routing the man pages to neovim
			export MANPAGER='nvim +Man!'

			export PATH=/home/aksh/.npm-global/bin:$PATH
		'';
	};
}
