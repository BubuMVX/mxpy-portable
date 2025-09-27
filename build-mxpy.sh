#!/usr/bin/env bash
set -e

# --- Configuration
APP_NAME="mxpy"
REPO="multiversx/mx-sdk-py-cli"
WORKDIR="build-${APP_NAME}"
PYTHON_EXE="python3"

# Detect OS
OS="$(uname -s)"
case "$OS" in
    Linux*)     PLATFORM="linux"; ICON_OPT="";;
    Darwin*)    PLATFORM="macos"; ICON_OPT="--icon=../icon.icns";;
    CYGWIN*|MINGW*|MSYS*) PLATFORM="windows"; ICON_OPT="--icon=../icon.ico"; PYTHON_EXE="python";;
    *)          PLATFORM="unknown"; ICON_OPT="";;
esac

echo "[*] Detected platform: $PLATFORM"

echo "[*] Cleaning..."
rm -rf "$WORKDIR" dist build __pycache__
mkdir -p "$WORKDIR"
cd "$WORKDIR"

# --- Download latest release
echo "[*] Fetching the latest release of $REPO..."
LATEST_URL=$(curl -s https://api.github.com/repos/$REPO/releases/latest \
  | grep tarball_url \
  | cut -d '"' -f 4)
curl -L "$LATEST_URL" -o source.tar.gz

echo "[*] Extracting..."
tar -xzf source.tar.gz --strip 1

# --- Create virtual environment
echo "[*] Creating virtual environment..."
$PYTHON_EXE -m venv venv
if [ "$PLATFORM" = "windows" ]; then
    source venv/Scripts/activate
else
    source venv/bin/activate
fi

python -m pip install --upgrade pip
python -m pip install . pyinstaller

# --- Create wrapper script
echo "[*] Creating run_mxpy.py..."
cat > run_mxpy.py << 'EOF'
from multiversx_sdk_cli.cli import main

if __name__ == "__main__":
    main()
EOF

# --- Build portable binary
echo "[*] Building portable binary..."
pyinstaller --onefile \
  --clean \
  --optimize 2 \
  --name ${APP_NAME} \
  --hidden-import multiversx_sdk_cli \
  $ICON_OPT \
  run_mxpy.py

echo
echo "[OK] Executable ready in dist/ (platform: $PLATFORM)"
