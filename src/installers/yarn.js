import Listr from 'listr'
import chalk from 'chalk'

import execute from '../utils/execute'
import answers from '../utils/answers'

export const packages = ['gitmoji-cli', 'serve', 'tldr', 'n', 'tree']

export default {
  title: chalk.bold('Yarn packages'),
  skip: () => answers.get().yarn.length <= 0,
  task: () => {
    const packages = answers.get().yarn

    return new Listr(
      packages.map((name) => ({
        title: `Installing ${chalk.cyan.bold(name)}`,
        task: () => execute(`yarn global add ${name}`),
      })),
    )
  },
}
