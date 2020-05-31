import Listr, { ListrTask } from 'listr'
import chalk from 'chalk'

import execute from '../utils/execute'
import answers from '../utils/answers'

export const gems = ['iStats']

const task: ListrTask = {
  title: chalk.bold('Gems'),
  skip: () => answers.values.gem.length <= 0,
  task: () => {
    const gems = answers.values.gem

    return new Listr(
      gems.map((name) => ({
        title: `Installing ${chalk.cyan.bold(name)}`,
        task: () =>
          execute(
            `echo "${answers.values.password}" | sudo -S gem install ${name}`,
          ),
      })),
    )
  },
}

export default task
