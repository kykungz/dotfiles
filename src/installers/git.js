import inquirer from 'inquirer'
import chalk from 'chalk'
import execa from 'execa'
import Listr from 'listr'

import answers from '../utils/answers'

export default {
  setup: async () => {
    if (!answers.get().git) return

    console.log('\n')

    const { name, email } = await inquirer.prompt([
      {
        name: 'name',
        type: 'input',
        message: `Enter your GitHub full name ${chalk.dim('(John Doe)')}:`,
      },
      {
        name: 'email',
        type: 'input',
        message: `Enter your GitHub email:`,
      },
    ])

    await new Listr(
      [
        {
          // prettier-ignore
          title: `Setting ${chalk.cyan.bold('git')} name to ${chalk.yellow(name)}`,
          skip: () => !name,
          task: async () => {
            await execa.command(`git config --global user.name "${name}"`)
          },
        },
        {
          // prettier-ignore
          title: `Setting ${chalk.cyan.bold('git')} email to ${chalk.yellow(email)}`,
          skip: () => !email,
          task: async () => {
            await execa.command(`git config --global user.email "${email}"`)
          },
        },
        {
          // prettier-ignore
          title: `Setting ${chalk.cyan.bold('hub')} protocol to ${chalk.yellow('https')}`,
          task: async () => {
            await execa.command(`git config --global hub.protocol https`)
          },
        },
      ],
      {
        collapse: false,
        exitOnError: false,
      },
    ).run()
  },
}
