#########################################################################
# File Name: config_tmux.sh
# Author: pix
# mail: tpxsky@163.com
# Created Time: Tue 14 Apr 2020 06:35:10 AM UTC
# Description:
#########################################################################
#!/bin/env bash
git clone https://github.com/gpakosz/.tmux.git "${HOME}/.tmux"
ln -s -f "${HOME}/.tmux/.tmux.conf" "${HOME}/.tmux.conf"
cp "${HOME}/.tmux/.tmux.conf.local" "${HOME}"
cat "${HOME}/dev/install-arch/tmux/.tmux.conf" >>"${HOME}/.tmux.conf.local"
