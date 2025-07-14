# What

- Split zsh files for `.zshrc`.
- Create symbolic link of .zshrc
  - `ln -s ~/.zsh.d/zshrc ~/.zshrc`
  - `source ~/.zshrc`
- Create `profile.zsh` for environmental variables and `alias.zsh`
  for the project specific alias.
- Sensitive files like profile.zsh and alias.zsh have to be in `.gitignore`.
