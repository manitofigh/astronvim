This is a slightly-customized version of the Astronvim nvim configuration.

## Installation

### Step 0: Install the requirements

you need to install the following packages through your desired package manager:
```bash
ripgrep
lazygit
bottom
Python
Node
```

You also need a "Nerd Font" downloaded and set as your terminal's font, which has support for some of the symbols and icons used in the terminal.
Choose one from the list [at this page](https://www.nerdfonts.com/font-downloads)

### Step 1: Make a backup of your current nvim and shared folder

> [!NOTE]
> This step is for people who _already_ have an nvim config setup.
> If it's your first time dealing with nvim configs, don't bother with this step and jump to **Step 2**.

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### Step 2: Clone the repository to the config path

```shell
git clone https://github.com/manitofigh/astronvim ~/.config/nvim
```

### Finally: Start Neovim

```shell
nvim
```

Sit back and let the dependencies install.

## Uninstall (How to revert back to your old config)

This series of commands restore your old config that was backed up using commands in Step 1:
```bash
mv ~/.config/nvim ~/.config/nvim.new.bak
mv ~/.local/share/nvim ~/.local/share/nvim.new.bak
mv ~/.local/state/nvim ~/.local/state/nvim.new.bak
mv ~/.cache/nvim ~/.cache/nvim.new.bak

mv ~/.config/nvim.bak ~/.config/nvim
mv ~/.local/share/nvim.bak ~/.local/share/nvim
mv ~/.local/state/nvim.bak ~/.local/state/nvim
mv ~/.cache/nvim.bak ~/.cache/nvim
```
