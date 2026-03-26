# Dotfiles

My terminal configuration managed with [chezmoi](https://www.chezmoi.io/).

## What's Included

- **Zsh** configuration (`.zshrc`, `.zprofile`)
- **Vim** configuration (`.vim`)
- **Starship** prompt customization
- **Ghostty** terminal config

## Installation

### Quick Install (Recommended)

Run this command on a new server:

```bash
sh -c "$(curl -fsSL https://get.chezmoi.io)" && \
git clone https://github.com/octopusmorgan/dotfiles.git ~/.dotfiles && \
chezmoi init --source ~/.dotfiles && chezmoi apply
```

### Using the Install Script

```bash
curl -fsSL https://raw.githubusercontent.com/octopusmorgan/dotfiles/master/install.sh -o install.sh
chmod +x install.sh
./install.sh
```

The script will:
1. Install chezmoi if not present
2. Clone this repository to `~/.dotfiles`
3. Initialize chezmoi
4. Apply the configuration

## Usage

| Command | Description |
|---------|-------------|
| `chezmoi status` | View pending changes |
| `chezmoi diff` | Show differences |
| `chezmoi apply` | Apply changes to system |
| `chezmoi edit ~/.zshrc` | Edit a managed file |
| `chezmoi add ~/.newfile` | Add a new file to management |

## Updating

After making changes locally:

```bash
chezmoi edit ~/.zshrc
chezmoi apply
cd ~/.local/share/chezmoi
git add -A
git commit -m "Update dotfiles"
git push
```

Then on other machines:
```bash
~/.dotfiles/install.sh
```

## Requirements

- Zsh
- [Oh My Zsh](https://ohmyz.sh/)
- [Starship](https://starship.rs/) prompt
- [Ghostty](https://ghostty.org/) terminal (optional)

## License

MIT
