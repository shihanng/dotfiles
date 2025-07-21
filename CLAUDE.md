# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with [chezmoi](https://www.chezmoi.io/) for cross-platform configuration management. The repository contains:

- **Home directory configurations** (`home/`) - dotfiles managed by chezmoi
- **Neovim configuration** (`home/dot_config/nvim/`) - comprehensive Lua-based Neovim setup
- **Ansible playbooks** (`ansible/`) - system setup automation
- **Tool configurations** - various CLI tools and applications

## Key Commands

### Development and Linting

- **Lua linting**: `luacheck` (installed via mise, configured in `selene.toml` and `neovim.yml`)
- **Lua formatting**: `stylua` (configured in `stylua.toml`)
- **TOML formatting**: `taplo fmt` (installed via mise)
- **Ansible playbook**: `mise x ansible -- ansible-playbook -K site.yml` (from `ansible/` directory)

### Setup and Management

- **Initial setup**: `chezmoi init -S ~/dotfiles --exclude=encrypted --apply`
- **Install tools**: `mise install`
- **Update configurations**: `chezmoi apply`
- **Age key setup**: `op document get "Chezmoi Age" -o $HOME/key.txt`

### Environment

- **Shell**: Zsh with mise activation: `eval "$(~/.local/bin/mise activate zsh)"`
- **Python management**: `mise use -g python` then `pip install --user pipx`
- **Rust tools**: `mise use -g cargo-binstall`

## Architecture

### Configuration Management

- **chezmoi** manages all dotfiles with templates (`.tmpl` files) and encrypted secrets (`.age` files)
- **mise** (`mise.toml`) handles tool version management and environment setup
- **Ansible** (`ansible/`) automates system package installation and setup

### Neovim Structure

- **Plugin management**: Uses lazy.nvim with plugins in `home/dot_config/nvim/lua/plugins/`
- **Personal configs**: Located in `home/dot_config/nvim/lua/shihanng/` to avoid namespace collisions
- **Key bindings**: Leader key is `,` (comma), local leader is `;` (semicolon)
- **Python integration**: Uses mise-installed Python at `$HOME/.local/share/mise/installs/python/latest/bin/python`

### Directory Structure

```
home/                           # chezmoi-managed home directory files
├── dot_config/                 # Application configurations
│   ├── nvim/                   # Neovim configuration
│   │   ├── lua/shihanng/       # Personal Lua modules (namespace-safe)
│   │   └── lua/plugins/        # Plugin configurations
│   ├── mise/                   # mise tool configuration
│   └── [other tools]/          # Various tool configurations
├── dot_zshrc.tmpl              # Zsh configuration template
├── dot_gitconfig.tmpl          # Git configuration template
└── encrypted_*.age             # Age-encrypted secret files
```

### Key Files

- `mise.toml`: Tool version management and Lua environment setup
- `selene.toml` & `neovim.yml`: Lua linting configuration for Neovim
- `stylua.toml`: Lua code formatting configuration
- `ansible/site.yml`: System setup automation

## Development Workflow

1. **Making changes**: Edit files in `home/` directory
2. **Testing Lua code**: Use `luacheck` and `stylua` for linting/formatting
3. **Formatting TOML files**: Use `taplo fmt` for TOML formatting
4. **Applying changes**: Run `chezmoi apply` to update actual dotfiles
5. **System setup**: Use Ansible playbook for installing new system packages

## Important Notes

- All Lua files should be placed in `shihanng/` subdirectory to prevent namespace collisions
- Encrypted files use age encryption and require the age key setup
- Templates (`.tmpl` files) are processed by chezmoi with context variables
- Pre-commit hooks automatically run luacheck, stylua, taplo, prettier, and sort-lines
- The repository supports both macOS and Linux through Ansible role conditionals

