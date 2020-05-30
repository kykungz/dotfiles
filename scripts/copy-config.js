const execa = require('execa')
const path = require('path')

const configPath = path.join(__dirname, '../configs')

execa.command(
  `
    cp ~/Library/Preferences/com.apple.Terminal.plist ${configPath};
    cp ~/Library/Preferences/com.googlecode.iterm2.plist ${configPath};
  `,
  { shell: true, stdio: 'inherit' },
)
