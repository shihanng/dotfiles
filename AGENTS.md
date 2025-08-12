# Agent Development Guide

## Build/Lint/Test Commands

- **Lua linting**: `luacheck` (configured via `selene.toml` and `neovim.yml`)
- **Lua formatting**: `stylua` (spaces, collapse simple statements)
- **TOML formatting**: `taplo fmt`
- **YAML formatting**: `prettier`
- **Run all checks**: Pre-commit hooks handle luacheck, stylua, taplo, prettier, sort-lines
- **Apply configs**: `chezmoi apply`
- **System setup**: `mise x ansible -- ansible-playbook -K site.yml` (from `ansible/` dir)

## Code Style Guidelines

- **Lua**: Use `vim.` API over deprecated functions, 4-space indentation, snake_case
- **Namespace**: Place personal Lua code for Neovim in `shihanng/` to avoid collisions
- **Neovim globals**: `vim` and `Snacks` are predefined globals
- **Leader keys**: `,` (leader), `;` (local leader)
- **Comments**: Include for complex logic, avoid obvious comments
- **Error handling**: Use pcall for risky operations, provide meaningful messages

## File Structure

- Personal configs in `home/dot_config/nvim/lua/shihanng/`
- Plugin configs in `home/dot_config/nvim/lua/plugins/`
- Templates use `.tmpl` extension, secrets use `.age` encryption
- Tool configs in respective `dot_config/` subdirectories

