# nvim

Use below command to install nvim configuration

```bash
git clone https://github.com/VarunSharma3520/nvim.git && mv nvim ~/.config/ && nvim && cd ~
```

### Comamand to Start GitHub Codespace
```bash
docker run -p 3000:3000 -p 3001:3001 -v $(pwd):/code --rm -it mcr.microsoft.com/vscode/devcontainers/universal /bin/sh
```

>  nvim not installed

run below script to make instail setup

```bash
#!/usr/bin/env bash
set -e

echo "=============================="
echo "  UBUNTU AUTO INSTALL SCRIPT  "
echo "=============================="

# Update system
echo "[+] Updating system..."
sudo apt update && sudo apt upgrade -y

# Base packages
echo "[+] Installing base packages..."
sudo apt install -y \
  curl \
  wget \
  git \
  ca-certificates \
  gnupg \
  lsb-release \
  software-properties-common \
  unzip

# -------------------------
# REMOVE USELESS DEFAULT APPS
# -------------------------
echo "[+] Removing unwanted default apps..."

sudo apt purge -y \
  rhythmbox \
  evince \
  simple-scan \
  cheese \
  thunderbird \
  libreoffice* \
  aisleriot \
  mahjongg \
  gnome-mines \
  gnome-sudoku

sudo apt autoremove -y
sudo apt autoclean -y

# -------------------------
# GNOME Tweaks & Extensions
# -------------------------
echo "[+] Installing GNOME Tweaks & Extensions..."
sudo apt install -y gnome-tweaks gnome-shell-extensions gnome-shell-extension-manager

# -------------------------
# Install Docker (Official)
# -------------------------
echo "[+] Installing Docker..."

sudo apt remove -y docker docker-engine docker.io containerd runc || true

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# -------------------------
# Install Neovim (LATEST)
# -------------------------
echo "[+] Installing Neovim (latest)..."
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim

# -------------------------
# Install VS Code (Official)
# -------------------------
echo "[+] Installing VS Code..."

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
rm -f packages.microsoft.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/packages.microsoft.gpg] \
https://packages.microsoft.com/repos/code stable main" | \
sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

sudo apt update
sudo apt install -y code

# -------------------------
# macOS Theme & Icons
# -------------------------
echo "[+] Installing macOS GNOME Theme & Icons..."

mkdir -p ~/themes && cd ~/themes

# WhiteSur macOS Theme
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
cd WhiteSur-gtk-theme
./install.sh -d ~/.themes
cd ..

# WhiteSur macOS Icons
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
cd WhiteSur-icon-theme
./install.sh -d ~/.icons
cd ..

# macOS Cursor
git clone https://github.com/vinceliuice/WhiteSur-cursors.git
cd WhiteSur-cursors
./install.sh
cd ..

# Apply Theme Automatically
echo "[+] Applying macOS Look..."

gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-Dark"
gsettings set org.gnome.desktop.interface icon-theme "WhiteSur-dark"
gsettings set org.gnome.desktop.interface cursor-theme "WhiteSur-cursors"
gsettings set org.gnome.shell.extensions.user-theme name "WhiteSur-Dark"

# -------------------------
# Final Output
# -------------------------
echo "=============================="
echo "  INSTALLATION COMPLETE ✅"
echo "=============================="

echo ""
echo "Installed:"
echo "✅ GNOME Tweaks + Extensions"
echo "✅ Docker (official latest)"
echo "✅ Neovim (latest)"
echo "✅ VS Code"
echo "✅ macOS GNOME Theme + Icons + Cursor"
echo "✅ System cleaned from useless offline apps"

echo ""
echo "⚠️ IMPORTANT:"
echo "1) Log out & log back in for Docker permissions."
echo "2) Reboot recommended for full theme activation."
echo ""
echo "DONE ✅"

```
