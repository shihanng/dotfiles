## Prerequisites

1. Make sure user is using Zsh.

2. Install [Homebrew](https://brew.sh/) if on macOS.

3. Clone this repository onto home.

   ```console
   git clone https://github.com/shihanng/dotfiles
   ```

4. Install [Rust](https://www.rust-lang.org/tools/install).

5. Install [chezmoi](https://www.chezmoi.io/install/).

6. Install [mise](https://mise.jdx.dev/getting-started.html).

   ```console
   eval "$(~/.local/bin/mise activate zsh)"
   mise use -g python
   pip install --user pipx
   mise use -g cargo-binstall
   ```

7. Execute [Ansible](./ansible/).

   ```console
   cd ansible
   ~/.local/bin/mise x ansible -- ansible-playbook -K site.yml
   ```

8. Run chezmoi apply.

   ```console
   ~/bin/chezmoi init -S ~/dotfiles --exclude=encrypted --apply
   ```

9. Run mise install.

   ```console
   mise install
   ```

10. Setup age key.

    ```console
    op document get "Chezmoi Age" -o $HOME/key.txt
    ```

## Development

We use [mise to install luacheck](./mise.toml).
