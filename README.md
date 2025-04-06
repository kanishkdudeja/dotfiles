# dotfiles

## Notes

- This is largely set up to support Linux (deb based distributions like Ubuntu and PopOS) and MacOS.

## Installation

### Pre-requisites

- Install Zsh and set it as your default shell.

### Set up

- Navigate to your home folder: `cd ~/`
- Clone this Git repository: `git clone git@github.com:kanishkdudeja/dotfiles.git`.
  - If SSH keys aren't set up, you can set up GitHub CLI and run `gh repo clone https://github.com/kanishkdudeja/dotfiles`.
- To install Zsh, run `cd ~/dotfiles/ && bash zsh/install.sh`
  - It should be installed by default on MacOS.
- Log out and log back in again to use your new default shell.
- Run `cd ~/dotfiles/ && zsh install.sh`

### Manual Steps

#### Enable the prompt of your choice in ZSH configuration

- Enable the prompt of your choice in ~/.zshrc
  - Both Oh My Posh and Starship prompts are installed and configured by the install script.
- Restart your terminal

#### Terminal Font and Color Scheme

- Set your terminal app to use one of the Nerd fonts in your terminal settings.
- Use an appropriate color scheme for your prompt

#### Oh My Posh theme tweaks

If you want to add a space after each prompt for Oh My Posh themes, add the following as the first block in the blocks array in your theme file (eg: ~/.oh-my-posh-themes/M365Princess.omp.json):

```
{
    "type": "newline"
}
```
