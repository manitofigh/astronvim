This is a slightly-customized version of the Astronvim nvim configuration.

## Installation

#### Make a backup of your current nvim and shared folder

> [!IMPORTANT]
> This step is for people who _already_ have a setup an nvim config.
> If it's your first time dealing with nvim configs, don't bother with this section.

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Create a new user repository from this template

Press the "Use this template" button above to create a new repository to store your user configuration.

You can also just clone this repository directly if you do not want to track your user configuration in GitHub.

#### Clone the repository

```shell
git clone https://github.com/manitofigh/astronvim ~/.config/nvim
```

#### Start Neovim

```shell
nvim
```
