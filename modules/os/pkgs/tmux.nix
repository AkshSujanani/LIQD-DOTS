{ pkgs, inputs, ... }:

{
	programs.tmux = {
		enable = true;
		plugins = [
			pkgs.tmuxPlugins.tokyo-night-tmux
			inputs.tmux-nerd-font-window-name.packages.${pkgs.system}.default
		];

		extraConfig = ''
			# reload config file
			unbind r
			bind r source-file ~/.tmux.conf

			# Unbind the default prefix
			unbind M-Space
			# Set the new prefix to Alt+Space
			set-option -g prefix M-Space
			bind-key C-s send-prefix

			# split panes using | and -
			# to split panes horizontal and vertical
			bind | split-window -h
			bind - split-window -v
			unbind '"'
			unbind %

			# mouse usage enabled
			set -g mouse on

			# mouse usage enabled
			set -g mouse on

			# pane movement from arrow to -> hjkl
			bind-key h select-pane -L
			bind-key j select-pane -D
			bind-key k select-pane -U
			bind-key l select-pane -R

			# Enable two lines for the status bar
			set -g status 2
			# Set the second line (index 1) to be empty
			set -g 'status-format[1]' ""

			set-option -g status-position top

			set -g default-terminal "tmux-256color"
			set-option -sa terminal-overrides ",xterm*:Tc"

		# configure Tokyo-night
			set -g @tokyo-night-tmux_theme "night"
			set -g @tokyo-night-tmux_transparent 1

		# Icon styles
			set -g @tokyo-night-tmux_terminal_icon 
			set -g @tokyo-night-tmux_active_terminal_icon 

			set -g @tokyo-night-tmux_window_id_style digital
			set -g @tokyo-night-tmux_pane_id_style hsquare
			set -g @tokyo-night-tmux_zoom_id_style dsquare

		# Date and Time
			set -g @tokyo-night-tmux_show_datetime 0
			set -g @tokyo-night-tmux_date_format DMY
			set -g @tokyo-night-tmux_time_format 12H

		# Battery widgets
			set -g @tokyo-night-tmux_show_battery_widget 1
			set -g @tokyo-night-tmux_battery_name "BAT1"

		# Requires github-cli or gitlab-cli
			set -g @tokyo-night-tmux_show_wbg 0

		# Hostname widget
			set -g @tokyo-night-tmux_show_hostname 1

		# Force transparent status bar
		  set -g status-bg default
		  set -g status-style bg=default
		  
		# Ensure pane borders don't render solid blocks
		  set -g pane-border-style bg=default
		  set -g pane-active-border-style bg=default
		'';
	};
}
