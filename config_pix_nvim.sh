#!/bin/bash

COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

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
  echo -e "${COLOR_GREEN}extras exsists in ${file_path}${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}extras dont exsists in ${file_path}${COLOR_NC}"
fi

# 输出变量内容到临时文件
# echo "$lazyvim_extras" >/tmp/lazyvim_extras.txt

# 使用sed命令在指定行后插入临时文件的内容
# sed -i "/{ \"LazyVim\\/LazyVim\", import = \"lazyvim.plugins\" },/ r /tmp/lazyvim_extras.txt" "$file_path"

# 删除临时文件（可选）
# rm /tmp/lazyvim_extras.txt
