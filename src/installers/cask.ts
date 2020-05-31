import Listr, { ListrTask } from 'listr'
import chalk from 'chalk'

import execute from '../utils/execute'
import answers from '../utils/answers'

export const casks = [
  'visual-studio-code',
  'google-cloud-sdk',
  'textmate',
  'ngrok',
  'sequel-pro',
  'sourcetree',
  'postman',
  'docker',
  'google-chrome',
  'firefox',
  'vlc',
  'betterzip',
  'imageoptim',
  'spectacle',
  'spotify',
  'slack',
  'discord',
]

const task: ListrTask = {
  title: chalk.bold('Applications'),
  skip: () => answers.values.cask.length <= 0,
  task: () => {
    const casks = answers.values.cask

    return new Listr(
      casks.map((name) => ({
        title: `Installing ${chalk.cyan.bold(name)}`,
        task: () => execute(`brew cask install ${name}`),
      })),
      {
        concurrent: 5,
      },
    )
  },
}

export default task
