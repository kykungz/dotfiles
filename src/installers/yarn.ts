import Listr, { ListrTask } from 'listr'
import chalk from 'chalk'

import execute from '../utils/execute'
import answers from '../utils/answers'

export const packages = ['serve', 'tldr', 'n', 'tree', 'commitizen', 'git-cz']

const task: ListrTask = {
  title: chalk.bold('Yarn packages'),
  skip: () => answers.values.yarn.length <= 0,
  task: () => {
    const packages = answers.values.yarn

    return new Listr(
      packages.map((name) => ({
        title: `Installing ${chalk.cyan.bold(name)}`,
        task: () => execute(`yarn global add ${name}`),
      })),
    )
  },
}
export default task
