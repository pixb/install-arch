#!/usr/bin/env bash
# install_river.sh - 安装 river + kwm (与参考项目一致)
# 参考: https://codeberg.org/unixchad/kwm

set -e

COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_BLUE='\033[0;34m'
COLOR_NC='\033[0m'

ZIG_VERSION="0.16.0"
ZIG_PATH="/opt/zig-x86_64-linux-${ZIG_VERSION}"
export PATH="$ZIG_PATH:$PATH"

log_info() { echo -e "${COLOR_BLUE}[INFO]${COLOR_NC} $1"; }
log_ok() { echo -e "${COLOR_GREEN}[OK]${COLOR_NC} $1"; }
log_err() { echo -e "${COLOR_RED}[ERROR]${COLOR_NC} $1"; }

SRC_DIR="$HOME/.local/src"

export PATH="/opt/zig-x86_64-linux-${ZIG_VERSION}:/usr/local/bin:$PATH"

# ========== 步骤 1: 安装编译依赖 ==========
step1_deps() {
  log_info "=== 步骤 1: 安装编译依赖 ==="

  if [ -d "$ZIG_PATH" ] && [ -x "$ZIG_PATH/zig" ]; then
    log_ok "Zig 目录已存在: $ZIG_PATH"
  elif command -v zig &>/dev/null && zig version &>/dev/null; then
    local zig_ver=$(zig version 2>/dev/null)
    if [ "$zig_ver" = "$ZIG_VERSION" ]; then
      log_ok "Zig 已是目标版本: $ZIG_VERSION"
    else
      log_info "下载 zig $ZIG_VERSION..."
      local zig_url="https://ziglang.org/download/${ZIG_VERSION}/zig-x86_64-linux-${ZIG_VERSION}.tar.xz"
      local zig_file="/tmp/zig-linux-x86_64.tar.xz"

      wget -q -O "$zig_file" "$zig_url" || curl -sL "$zig_url" -o "$zig_file"
      sudo rm -rf /opt/zig
      sudo tar -xf "$zig_file" -C /opt
      sudo ln -sf /opt/zig-x86_64-linux-${ZIG_VERSION}/bin/zig /usr/local/bin/zig
      rm -f "$zig_file"
      log_ok "Zig $ZIG_VERSION 安装完成"
    fi
  else
    log_info "下载 zig $ZIG_VERSION..."
    local zig_url="https://ziglang.org/download/${ZIG_VERSION}/zig-x86_64-linux-${ZIG_VERSION}.tar.xz"
    local zig_file="/tmp/zig-linux-x86_64.tar.xz"

    wget -q -O "$zig_file" "$zig_url" || curl -sL "$zig_url" -o "$zig_file"
    sudo rm -rf /opt/zig
    sudo tar -xf "$zig_file" -C /opt
    sudo ln -sf /opt/zig-x86_64-linux-${ZIG_VERSION}/bin/zig /usr/local/bin/zig
    rm -f "$zig_file"
    log_ok "Zig $ZIG_VERSION 安装完成"
  fi

  sudo pacman -S --needed wlroots0.20 scdoc tllist wayland-protocols --noconfirm
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
    sudo env "PATH=$ZIG_PATH:$PATH" SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt "$ZIG_PATH/zig" build -Doptimize=ReleaseSafe --prefix /usr/local install
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

    # 下载 mvzr 依赖
    local mvzr_file="/tmp/mvzr-0.3.8.tar.gz"
    local mvzr_dir="$SRC_DIR/mvzr"
    if [ ! -f "$mvzr_dir/mvzr-0.3.8/build.zig" ]; then
      wget -q -O "$mvzr_file" "https://github.com/mnemnion/mvzr/archive/refs/tags/v0.3.8.tar.gz"
      mkdir -p "$mvzr_dir"
      tar -xf "$mvzr_file" -C "$mvzr_dir"
      rm -f "$mvzr_file"
    fi

    # 修改 build.zig.zon 使用相对路径
    if grep -q 'url = "https://github.com/mnemnion/mvzr' "$src_dir/build.zig.zon"; then
      sed -i 's|.url = "https://github.com/mnemnion/mvzr/archive/refs/tags/v0.3.8.tar.gz",|.path = "../../mvzr/mvzr-0.3.8",|' "$src_dir/build.zig.zon"
      sed -i '/mvzr-0.3.7-ZSOky1dvAQDTEE/d' "$src_dir/build.zig.zon"
      log_info "已修改 mvzr 依赖为相对路径"
    fi

    rm -rf .zig-cache zig-cache zig-out
    sudo env "PATH=$ZIG_PATH:$PATH" SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt "$ZIG_PATH/zig" build -Doptimize=ReleaseSafe --prefix /usr/local install
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

  # 链接参考项目的配置，或者创建基础配置
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
