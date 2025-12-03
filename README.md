
# Ubuntu step-by-step install & setup guide

> Run each command block **one at a time** (don’t paste the whole file). Where a command needs `sudo`, it’s marked. If a step requires a logout/reboot, that’s noted.

---

## 1) Update the system

Why: bring package lists and installed packages up-to-date.

```bash
sudo apt update
sudo apt upgrade -y
```

Verify:

```bash
lsb_release -a
```

---

## 2) Install base utilities

Why: tools commonly used by the rest of the steps.

```bash
sudo apt install -y curl wget git ca-certificates gnupg lsb-release software-properties-common unzip && git --version && curl --version
```

---

## 3) optional but recommended)

Why: manage themes and extensions easily.

```bash
sudo apt install -y gnome-tweaks gnome-shell-extensions gnome-shell-extension-manager && gnome-tweaks --version || echo "GNOME Tweaks installed (open via Activities)."
```

---

## 5) Install Docker (official)

Why: run containers and Codespaces devcontainers.

read [docker docs](https://docs.docker.com/desktop/setup/install/linux/ubuntu/)  

**Add Docker repo and install**

```bash
# remove old conflicting packages (if any)
sudo apt remove -y docker docker-engine docker.io containerd runc || true

# add Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg

# add Docker repo
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

**Enable & start**

```bash
sudo systemctl enable docker
sudo systemctl start docker
```

**Add current user to docker group (no password required for sudo earlier)**

```bash
sudo usermod -aG docker $USER
```

> **Note:** You must **log out and log back in** (or reboot) for the group change to take effect.

Verify:

```bash
docker --version
docker run --rm hello-world
docker rmi hello-world
```

* **Docker group change** needs logout/login (or reboot).
* Reboot if you installed desktop themes or changed many system packages:

```bash
sudo reboot
```


---

## 6) Install Neovim (recommended PPA for latest)

Why: you said `nvim` not installed — this installs a recent Neovim release.

```bash
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim
```

Verify:

```bash
nvim --version
```

**Install your Neovim config**

```bash
# clone and move config
git clone https://github.com/VarunSharma3520/nvim.git
mv nvim ~/.config/
# Launch nvim once to allow plugin managers to bootstrap
nvim
```

> If you use a plugin manager (lazy.nvim, packer, etc.), follow its bootstrap instructions when nvim opens.

---

## 7) Install Visual Studio Code (official Microsoft package)

Why: GUI code editor.

```bash
# import Microsoft GPG key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
rm -f packages.microsoft.gpg

# add repo & install
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
  | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

sudo apt update
sudo apt install -y code
```

Verify:

```bash
code --version
```

---

## 8) macOS look (theme & icons) — optional

Why: cosmetic. These scripts from third-party repos install themes and icons.

```bash
mkdir -p ~/themes && cd ~/themes

git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
cd WhiteSur-gtk-theme
./install.sh -d ~/.themes
cd ..

git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
cd WhiteSur-icon-theme
./install.sh -d ~/.icons
cd ..

git clone https://github.com/vinceliuice/WhiteSur-cursors.git
cd WhiteSur-cursors
./install.sh
cd ~
```

Apply theme:

```bash
gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-Dark"
gsettings set org.gnome.desktop.interface icon-theme "WhiteSur-dark"
gsettings set org.gnome.desktop.interface cursor-theme "WhiteSur-cursors"
gsettings set org.gnome.shell.extensions.user-theme name "WhiteSur-Dark"
```

> Note: sometimes `.install.sh` scripts prompt for choices. Read prompts before answering.

---

## 9) Start GitHub Codespace (local devcontainer) — Docker command

Why: run a Codespace-like devcontainer locally.

```bash
docker run -p 3000:3000 -p 3001:3001 -v "$(pwd)":/code --rm -it mcr.microsoft.com/vscode/devcontainers/universal /bin/sh
```

Adjust ports & volume path as needed.

---

---

## 10) Install mouseless

Build from source or install from Binary Release

```bash
git clone https://github.com/jbensmann/mouseless.git
cd mouseless
go build .
```

configuration file: ~/.config/mouseless/config.yaml

```bash
# configuration file: ~/.config/mouseless/config.yaml
# the default speed for mouse movement and scrolling
basemousespeed: 750.0
basescrollspeed: 20.0

# the shape of the acceleration curve, 1.0 is linear, higher values have more time at low speeds
mouseaccelerationcurve: 2.0

# the rest of the config defines the layers with their bindings
layers:
# the first layer is active at start
- name: initial
  bindings:
    # when tab is held and another key pressed, activate mouse layer
    capslock: tap-hold-next tab ; toggle-layer mouse ; 500
    # when a is held for 300ms, activate mouse layer
    a: tap-hold a ; toggle-layer mouse ; 300
# a layer for mouse movement
- name: mouse
  # when true, keys that are not mapped keep their original meaning
  passthrough: true
  # these commands are executed when the layer is entered/exited
  entercommand: "notify-send 'normal mode'"
  exitcommand: "notify-send 'insert mode'"
  bindings:
    # quit mouse layer
    q: layer initial
    # keep the mouse layer active
    space: layer mouse
    l: move 0.7  0
    h: move -0.7  0
    j: move  0  0.7
    k: move  0 -0.7
    u: scroll up
    d: scroll down
    r: speed 4.0
    e: speed 0.1
    f: button left
    m: button middle
    s: button right
```

run mouseless

```bash
sudo mouseless --config ~/.config/mouseless/config.yaml
```

> Note: the mouseless binary is installed in /usr/local/bin/mouseless. You may need to add this to your PATH.



















