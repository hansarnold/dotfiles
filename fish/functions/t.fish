function t --wraps='tmux attach-session' --description 'alias t=tmux attach-session'
    tmux attach-session $argv
end
