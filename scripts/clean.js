const execa = require('execa')
const consola = require('consola')

const clean = async () => {
  await execa.command(
    'rm -rf ~/.oh-my-zsh .zshrc ~/Library/Caches/Yarn ~/Library/Caches/Homebrew',
    { shell: true },
  )
  await execa.command(
    'brew uninstall yarn git ccat z hub mas inetutils httpie heroku --force',
    { shell: true },
  )
  await execa.command(
    'brew cask uninstall visual-studio-code google-cloud-sdk textmate ngrok sequel-pro sourcetree postman docker google-chrome firefox vlc betterzip imageoptim spectacle spotify slack discord --force',
    { shell: true },
  )

  consola.success('Done')
}

clean().catch(consola.error)
