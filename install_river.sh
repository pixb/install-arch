#!/usr/bin/env bash
# install_river.sh - 安装 river + kwm (与参考项目一致)
# 参考: https://codeberg.org/unixchad/kwm

set -e

COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_BLUE='\033[0;34m'
COLOR_NC='\033[0m'

ZIG_VERSION_RIVER="0.16.0"
ZIG_PATH_RIVER="/opt/zig-x86_64-linux-${ZIG_VERSION_RIVER}"

log_info() { echo -e "${COLOR_BLUE}[INFO]${COLOR_NC} $1"; }
log_ok() { echo -e "${COLOR_GREEN}[OK]${COLOR_NC} $1"; }
log_err() { echo -e "${COLOR_RED}[ERROR]${COLOR_NC} $1"; }

SRC_DIR="$HOME/.local/src"

# ========== 步骤 1: 安装编译依赖 ==========
step1_deps() {
  log_info "=== 步骤 1: 安装编译依赖 ==="

  if [ -d "$ZIG_PATH_RIVER" ] && [ -x "$ZIG_PATH_RIVER/zig" ]; then
    log_ok "Zig (river) 目录已存在: $ZIG_PATH_RIVER"
  else
    log_info "下载 zig $ZIG_VERSION_RIVER (river)..."
    local zig_url="https://ziglang.org/download/${ZIG_VERSION_RIVER}/zig-x86_64-linux-${ZIG_VERSION_RIVER}.tar.xz"
    local zig_file="/tmp/zig-river.tar.xz"
    wget -q -O "$zig_file" "$zig_url" || curl -sL "$zig_url" -o "$zig_file"
    sudo rm -rf "$ZIG_PATH_RIVER"
    sudo tar -xf "$zig_file" -C /opt
    rm -f "$zig_file"
    log_ok "Zig $ZIG_VERSION_RIVER 安装完成"
  fi

  if ! command -v zig &>/dev/null; then
    log_info "安装 zig (kwm)..."
    sudo pacman -S --noconfirm zig
  fi
  log_ok "Zig $(zig version) (kwm)"

  sudo pacman -S --needed wlroots0.20 scdoc tllist wayland-protocols sysstat --noconfirm
  log_ok "依赖安装完成"
}

# ========== 步骤 2: 编译安装 river (官方) ==========
step2_install_river() {
  log_info "=== 步骤 2: 编译安装 river ==="
  local src_dir="$SRC_DIR/river"
  if [ -f "/usr/local/bin/river" ]; then
    log_ok "river 已安装"
  else
    [ ! -d "$src_dir" ] && git clone https://codeberg.org/river/river "$src_dir"
    cd "$src_dir"
    export PATH="$ZIG_PATH_RIVER:$PATH"
    sudo env "PATH=$PATH" SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt "$ZIG_PATH_RIVER/zig" build -Doptimize=ReleaseSafe --prefix /usr/local install
    log_ok "river 安装完成"
  fi
}

# ========== 步骤 3: 编译安装 kwm ==========
step3_install_kwm() {
  log_info "=== 步骤 3: 编译安装 kwm ==="
  local src_dir="$SRC_DIR/kwm"
  if [ -f "/usr/local/bin/kwm" ]; then
    log_ok "kwm 已安装"
  else
    [ ! -d "$src_dir" ] && git clone https://codeberg.org/unixchad/kwm "$src_dir"
    cd "$src_dir"
    git checkout master
    rm -rf .zig-cache zig-cache zig-out
    sudo env "PATH=/usr/local/bin:/usr/bin:$PATH" SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt zig build -Doptimize=ReleaseSafe --prefix /usr/local install
    log_ok "kwm 安装完成"
  fi
}

# ========== 步骤 4: 安装 damblocks ==========
step4_install_damblocks() {
  log_info "=== 步骤 4: 安装 damblocks ==="
  mkdir -p "$HOME/.local/bin"
  local src_dir="$SRC_DIR/damblocks"
  if [ -f "$HOME/.local/bin/damblocks" ]; then
    log_ok "damblocks 已安装"
  else
    [ ! -d "$src_dir" ] && git clone https://codeberg.org/unixchad/damblocks "$src_dir"
    cp "$src_dir/damblocks" "$HOME/.local/bin/"
    chmod +x "$HOME/.local/bin/damblocks"
    log_ok "damblocks 安装完成"
  fi
}

# ========== 步骤 5: 配置 ==========
step5_config() {
  log_info "=== 步骤 5: 配置 ==="

  mkdir -p ~/.config/river

  if [ -f ~/dev/code/github/unixchad/dotfiles/.config/river/init ]; then
    ln -sf ~/dev/code/github/unixchad/dotfiles/.config/river/init ~/.config/river/init
  else
    cat >~/.config/river/init <<'EOF'
#!/usr/bin/env sh
# river + kwm init

/usr/local/bin/kwm &
${HOME}/.local/bin/damblocks --fifo &
EOF
    chmod +x ~/.config/river/init
  fi
  log_ok "配置完成"
}

main() {
  echo "=== River + kwm 安装 (与参考项目一致) ==="
  echo ""

  step1_deps
  step2_install_river
  step3_install_kwm
  step4_install_damblocks
  step5_config

  echo ""
  echo "=== 安装完成 ==="
  echo "启动: river"
  echo "配置目录: ~/.config/river/"
}

main "$@"