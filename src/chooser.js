import inquirer from 'inquirer'
import chalk from 'chalk'
import consola from 'consola'

import { formulas } from './installers/brew'
import { packages } from './installers/yarn'
import { casks } from './installers/cask'
import { gems } from './installers/gem'
import installer from './installer'
import answers from './utils/answers'

const start = async () => {
  const promptAnswers = await inquirer.prompt([
    {
      name: 'zsh',
      type: 'confirm',
      message: `Do you want to install ${chalk.green('Z Shell')}:`,
    },
    {
      name: 'iterm2',
      type: 'confirm',
      message: `Do you want to install ${chalk.green('iTerm2')}:`,
    },
    {
      name: 'git',
      type: 'confirm',
      message: `Do you want to setup ${chalk.green('Git')}:`,
    },
    {
      name: 'brew',
      type: 'checkbox',
      pageSize: formulas.length,
      message: `Select ${chalk.green('Homebrew')} formulas:`, // prettier-ignore
      choices: formulas.map((formula) => ({
        name: chalk.cyan.bold(formula),
        value: formula,
        checked: true,
      })),
    },
    {
      name: 'yarn',
      type: 'checkbox',
      pageSize: packages.length,
      message: `Select ${chalk.green('Yarn')} packages:`, // prettier-ignore
      choices: packages.map((pkg) => ({
        name: chalk.cyan.bold(pkg),
        value: pkg,
        checked: true,
      })),
    },
    {
      name: 'cask',
      type: 'checkbox',
      pageSize: casks.length,
      message: `Select ${chalk.green('Applications')}:`, // prettier-ignore
      choices: casks.map((cask) => ({
        name: chalk.cyan.bold(cask),
        value: cask,
        checked: true,
      })),
    },
    {
      name: 'gem',
      type: 'checkbox',
      pageSize: gems.length,
      message: `Select ${chalk.green('Gems')}:`, // prettier-ignore
      choices: gems.map((gem) => ({
        name: chalk.cyan.bold(gem),
        value: gem,
        checked: true,
      })),
    },
    {
      name: 'password',
      message: 'Enter your Mac password (for further installations):',
      type: 'password',
      validate: (input) => {
        if (input) return true
        return 'Please enter your password'
      },
    },
  ])

  console.log()
  consola.info('Starting your installations...\n')

  answers.set(promptAnswers)

  await installer.start()
}

console.clear()
start()
