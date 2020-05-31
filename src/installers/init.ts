import Listr, { ListrTask } from 'listr'
import chalk from 'chalk'

import execute from '../utils/execute'

const task: ListrTask = {
  title: chalk.bold('Initialize'),
  task: () => {
    return new Listr([
      {
        title: 'Updating Homebrew',
        task: () => execute('brew update'),
      },
      {
        title: 'Creating ~/Developer directory',
        task: () => execute('mkdir ~/Developer'),
      },
    ])
  },
}

export default task
