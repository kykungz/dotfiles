import Listr from 'listr'
import path from 'path'
import chalk from 'chalk'

import execute from '../utils/execute'
import answers from '../utils/answers'
import delay from '../utils/delay'
import pathPrefix from '../utils/pathPrefix'

const settingPath = path.join(
  __dirname,
  pathPrefix,
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
        title: `Initializing ${chalk.cyan.bold('iterm2')} settings`,
        task: () => execute(`open -a "iTerm"`),
      },
      {
        title: `Importing ${chalk.cyan.bold('iterm2')} settings`,
        task: async () => {
          await delay(3000)
          return execute(`cp -f ${settingPath} ~/Library/Preferences/`)
        },
      },
    ]),
}
