import Listr, { ListrTask } from 'listr'
import chalk from 'chalk'

import execute from '../utils/execute'
import answers from '../utils/answers'

export const formulas = [
  'heroku',
  'yarn',
  'git',
  'ccat',
  'z',
  'gh',
  'mas',
  'inetutils',
  'httpie',
  'gitmoji',
]

const task: ListrTask = {
  title: chalk.bold('Homebrew formulas'),
  skip: () => answers.values.brew.length <= 0,
  task: () => {
    const formulas = answers.values.brew

    return new Listr([
      {
        title: `Downloading formulas`,
        task: () =>
          execute(`brew tap heroku/brew && brew fetch ${formulas.join(' ')}`),
      },
      ...formulas.map((name) => ({
        title: `Installing ${chalk.cyan.bold(name)}`,
        task: () => execute(`HOMEBREW_NO_AUTO_UPDATE=1 brew install ${name}`),
      })),
    ])
  },
}

export default task
