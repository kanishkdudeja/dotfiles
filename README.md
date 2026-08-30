# dotfiles

## Platforms

The repository has isolated installers for Omarchy 4 and Pop!_OS. The root
installer detects either platform, or accepts the platform explicitly.
macOS-only scripts and SSH configuration live under `macos/`, while the
AeroSpace configuration remains separate at the repository root.

## Installation

### Set up

- Clone this Git repository: `git clone git@github.com:kanishkdudeja/dotfiles.git`.
  - If SSH keys aren't set up, you can set up GitHub CLI and run `gh repo clone https://github.com/kanishkdudeja/dotfiles`.
- From the repository root, run `bash install.sh` to detect Omarchy or Pop!_OS.

### Omarchy 4

Omarchy uses an isolated installer so the legacy Debian/Pop!_OS components are
not run. Preview and install the configuration with:

```sh
bash install.sh omarchy --dry-run all
bash install.sh omarchy all
```

See the [Omarchy installer guide](omarchy/README.md) and the
[keyboard and workspace reference](docs/omarchy-keybindings.md) for component
installs, modifier roles, and the complete semantic workspace layout.

### Pop!_OS

Install Zsh and make it your default shell on a fresh Pop!_OS machine:

```sh
bash popos/zsh/install.sh
```

After logging out and back in, run the guarded Pop!_OS bundle:

```sh
bash install.sh popos
```

See the [Pop!_OS installer guide](popos/README.md). The Pop!_OS installer
refuses to run on Omarchy, other Arch systems, or macOS.

### Manual Steps

#### Enable the prompt of your choice in Pop!_OS ZSH configuration

- Enable the prompt of your choice in ~/.zshrc
  - Both Oh My Posh and Starship prompts are installed and configured by the install script.
- Restart your terminal.

#### Terminal Font and Color Scheme

- Set your terminal app to use one of the Nerd fonts in your terminal settings.
- Use an appropriate color scheme for your prompt.
