import Listr from 'listr'
import path from 'path'
import chalk from 'chalk'

import execute from '../utils/execute'
import answers from '../utils/answers'

const settingPath = path.join(
  __dirname,
  '../configs/com.googlecode.iterm2.plist',
)

export default {
  title: chalk.bold('iTerm2'),
  skip: () => !answers.get().iterm2,
  task: () =>
    new Listr([
      {
        title: `Installing ${chalk.cyan.bold('iterm2')}`,
        task: () => execute(`brew cask install iterm2`),
      },
      {
        title: `Importing ${chalk.cyan.bold('iterm2')} settings`,
        task: () => execute(`cp -f ${settingPath} ~/Library/Preferences/`),
      },
    ]),
}
