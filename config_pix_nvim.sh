#!/bin/bash

COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

function pacman_install() {
  if pacman -Qi "$1" &>/dev/null; then
    echo -e "${COLOR_GREEN}$1 is installed${COLOR_NC}"
  else
    echo -e "${COLOR_YELLOW}$1 is not install${COLOR_NC}"
    sudo pacman -S "$1" --noconfirm
  fi
}

function trizen_install() {
  if pacman -Qi "$1" &>/dev/null; then
    echo -e "${COLOR_GREEN}$1 is installed${COLOR_NC}"
  else
    echo -e "${COLOR_YELLOW}$1 is not install${COLOR_NC}"
    trizen -S "$1" --noconfirm
  fi
}

pacman_install nodejs
pacman_install npm
pacman_install fd

if [ -d ${HOME}/.config/nvim ]; then
  echo -e "${COLOR_GREEN}nvim config exists${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}nvim config exists${COLOR_NC}"
  git clone https://github.com/LazyVim/starter ~/.config/nvim
fi

######################################################################################################
# extras
######################################################################################################

# 使用EOF将多行文本存储到变量中
lazyvim_extras=$(
  cat <<'EOF'
    -- extras
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.editor.outline" },
    { import = "lazyvim.plugins.extras.util.dot" },
    { import = "lazyvim.plugins.extras.lang.clangd" },
    { import = "lazyvim.plugins.extras.lang.cmake" },
    { import = "lazyvim.plugins.extras.lang.python" },
EOF
)

# 输出变量内容以查看结果
echo "$lazyvim_extras"

# 定义文件路径
file_path="${HOME}/.config/nvim/lua/config/lazy.lua"

ls ${file_path}

if grep -q "dap.core" $file_path; then
  echo -e "${COLOR_GREEN}extras exists in ${file_path}${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}extras dont exists in ${file_path}${COLOR_NC}"
  # 输出变量内容到临时文件
  echo "$lazyvim_extras" >/tmp/lazyvim_extras.txt
  # 使用sed命令在指定行后插入临时文件的内容
  sed -i "/{ \"LazyVim\\/LazyVim\", import = \"lazyvim.plugins\" },/ r /tmp/lazyvim_extras.txt" "$file_path"
  # 删除临时文件（可选）
  rm /tmp/lazyvim_extras.txt
fi

######################################################################################################
# gruvbox
######################################################################################################

# 定义要替换的内容
cat <<'EOF' >>/tmp/nvim_gruvbox.txt
if true then return {
  { "ellisonleao/gruvbox.nvim" },
    {
      "LazyVim/LazyVim",
      opts = {
      colorscheme = "gruvbox",
    },
  },
} end
EOF

example_plugin_file="${HOME}/.config/nvim/lua/plugins/example.lua"
if grep -q "if true then return {} end" ${example_plugin_file}; then
  echo -e "${COLOR_YELLOW}not config gruvbox${COLOR_NC}"

  sed -i '/if true then return {} end/{r /tmp/nvim_gruvbox.txt
  d}' $example_plugin_file
  rm /tmp/nvim_gruvbox.txt
else
  echo -e "${COLOR_GREEN}config gruvbox is exists${COLOR_NC}"
fi

######################################################################################################
# keymap
######################################################################################################
keymap_file=${HOME}/.config/nvim/lua/config/keymaps.lua
if grep -q "jk" ${keymap_file}; then
  echo -e "${COLOR_GREEN}jk keymap is configure${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}configure jk keymap${COLOR_NC}"
  cat <<'EOF' >>${keymap_file}
  local keymap = vim.keymap
  keymap.set("i", "jk", "<Esc>")
EOF
fi

######################################################################################################
# plugin
######################################################################################################
cp $(pwd)/config/*.lua "${HOME}"/.config/nvim/lua/plugins
