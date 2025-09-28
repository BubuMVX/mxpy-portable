# mxpy portable builds

This repository provides **portable executables** of
the [MultiversX CLI (mxpy)](https://github.com/multiversx/mx-sdk-py-cli), automatically built from the latest official
releases.

For real usage examples, check out [EXAMPLES.md](EXAMPLES.md).

For full details, see the [official mxpy documentation](https://github.com/multiversx/mx-sdk-py-cli/blob/main/CLI.md).

## About

[mxpy](https://github.com/multiversx/mx-sdk-py-cli) is the official MultiversX command line interface.  
Since the original distribution requires Python and `pip`/`pipx`, this repository offers **prebuilt binaries** for quick
usage on different platforms:

- Windows (`mxpy-windows.exe`)
- macOS (`mxpy-macos`)
- Linux (`mxpy-linux`)

Binaries are built daily via GitHub Actions (see `.github/workflows/build.yml`).  
Each release in this repository mirrors the **tag** of the official release.

## Download

Go to the **[Releases](https://github.com/BubuMVX/mxpy-portable/releases)** page and download the binary for your OS:

- **Windows**: `mxpy-windows.exe`
- **macOS**: `mxpy-macos`
- **Linux**: `mxpy-linux`

Each release also includes:

- `SHA256SUMS.txt`: checksums to verify the integrity of the binaries.

## Usage

### Windows

Run:

```powershell
.\mxpy-windows.exe --help
```

### macOS / Linux

When you download a file from the internet, macOS puts a little "quarantine sticker" on it (an attribute named
`com.apple.quarantine`).

Gatekeeper sees that sticker and blocks the app until you explicitly allow it. Our binary isn’t Apple-notarized/signed,
so Gatekeeper shows a warning.

First, make it executable:

```bash
chmod +x mxpy-macos
```

Then, remove the quarantine lock:

```bash
xattr -d com.apple.quarantine ./mxpy-macos
```

If you get "Operation not permitted", run it as an admin:

```bash
sudo xattr -d com.apple.quarantine ./mxpy-macos
```

You can now use it:

```bash
./mxpy-macos --help
```

### Linux

Run:

```bash
chmod +x mxpy-linux
./mxpy-linux --help
```

## Verify checksums

From the release directory:

```bash
sha256sum -c SHA256SUMS.txt
```

## Manual build

To manually build a portable executable for your current system, you can use the script [build-mxpy.sh](build-mxpy.sh).

You will need these tools: Python 3 (with `pip` and `venv`), `curl`.

```bash
chmod +x build-mxpy.sh
./build-mxpy.sh
```

The created executable will be in the folder `./build-mxpy/dist/`.

This script works on Windows (with Cygwin), macOS and Linux.

## Automation

Workflow runs daily at **14:00 UTC**.

When a new official release of mx-sdk-py-cli is published, a matching release is automatically created here with
portable binaries.
