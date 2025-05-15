#!/bin/bash

# 1. Install Xcode Command Line Tools
echo "Installing Xcode Command Line Tools..."
xcode-select --install 2>/dev/null

# 2. Install Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed."
fi

# Update Homebrew
brew update

# 3. Install iTerm2
echo "Installing iTerm2..."
brew install --cask iterm2

# 4. Install nvm (Node Version Manager) and latest Node.js
echo "Installing nvm (Node Version Manager)..."
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
else
  echo "nvm already installed."
fi

echo "Installing latest Node.js..."
nvm install node

# 5. Install Miniconda (lightweight Conda)
echo "Installing Miniconda..."
brew install --cask miniconda

# 6. Install Python (using pyenv for version management)
echo "Installing pyenv and Python..."
brew install pyenv
pyenv install 3.11.8
pyenv global 3.11.8

# 7. Install Rust (via rustup)
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# 8. Install OpenJDK (Java Development Kit)
echo "Installing OpenJDK..."
brew install openjdk

# 9. Install yabai
echo "Installing yabai via Homebrew..."
brew install koekeishiya/formulae/yabai

echo "Installing yabai scripting addition (requires sudo)..."
sudo yabai --install-sa

# On macOS Big Sur, load scripting addition manually
if [[ "$(sw_vers -productVersion)" == 11.* ]]; then
  echo "Loading yabai scripting addition manually for macOS Big Sur..."
  sudo yabai --load-sa
fi

echo "Starting yabai service..."
brew services start yabai

echo "Please grant Accessibility permissions to yabai in System Preferences -> Privacy & Security -> Accessibility."
echo "After granting permissions, restart your machine or log out and back in."


# 10. Install Powerlevel10k theme for Zsh

echo "Installing Powerlevel10k theme..."

# Ensure Oh My Zsh is installed (if not already)
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Clone Powerlevel10k into Oh My Zsh custom themes directory
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

# Set Powerlevel10k as the Zsh theme in ~/.zshrc
if grep -q '^ZSH_THEME=' ~/.zshrc; then
  sed -i.bak 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
else
  echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc
fi

echo "Powerlevel10k installed and set as Zsh theme."
echo "Restart your terminal to start the configuration wizard, or run 'p10k configure' to customize your prompt."

# Optional: Install recommended fonts for Powerlevel10k (MesloLGS NF)
echo "Installing Powerlevel10k recommended fonts..."
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font

echo "Fonts installed. Please set your terminal font to 'MesloLGS NF' in your terminal/iTerm2 preferences."


echo "All requested tools are installed. Please restart your terminal."
