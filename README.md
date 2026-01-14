# dotfiles
My Linux dotfiles

## Установка

### VSCode

1. Скопируйте настройки:
```bash
cp vscode-settings/settings.json ~/.config/Code/User/settings.json
```

2. Установите расширения:
```bash
cd vscode-settings && cat extensions.txt | xargs -L 1 code --install-extension
```

### Cursor

1. Скопируйте настройки:
```bash
cp cursor-settings/setting.json ~/.config/Cursor/User/settings.json
```

2. Установите расширения:
```bash
cd cursor-settings && cat extensions.txt | xargs -L 1 cursor --install-extension
```

### tmux

1. Скопируйте конфигурацию:
```bash
cp .tmux.conf ~/.tmux.conf
```

2. Установите TPM (если еще не установлен):
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

3. Запустите tmux и нажмите `Prefix + I` для установки плагинов

### vim

```bash
cp .vimrc ~/.vimrc
```

### Neovim

```bash
cp -r .config/nvim ~/.config/
```

### Emacs

```bash
cp -r .config/emacs ~/.config/
```