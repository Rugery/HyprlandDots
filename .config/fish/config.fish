#source /usr/share/cachyos-fish-config/cachyos-config.fish
nvm use lts > /dev/null 2>&1
set -gx QT_VERSION 5
set -gx QT_QPA_PLATFORM_PLUGIN_PATH /usr/lib/qt5/plugins

alias zk='zellij kill-all-sessions'
alias z='zellij'
