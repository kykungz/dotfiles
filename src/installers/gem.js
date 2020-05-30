import Listr from 'listr'
import chalk from 'chalk'

import execute from '../utils/execute'
import answers from '../utils/answers'

export const gems = ['iStats']

export default {
  title: chalk.bold('Gems'),
  skip: () => answers.get().gem.length <= 0,
  task: () => {
    const gems = answers.get().gem

    return new Listr(
      gems.map((name) => ({
        title: `Installing ${chalk.cyan.bold(name)}`,
        task: () =>
          execute(
            `echo "${answers.get().password}" | sudo -S gem install ${name}`,
          ),
      })),
    )
  },
}
