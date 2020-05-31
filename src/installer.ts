import Listr from 'listr'
import execa from 'execa'
import fs from 'fs'
import path from 'path'
import chalk from 'chalk'
import consola from 'consola'
import os from 'os'

import init from './installers/init'
import brew from './installers/brew'
import yarn from './installers/yarn'
import zsh from './installers/zsh'
import iterm2 from './installers/iterm2'
import cask from './installers/cask'
import git from './installers/git'
import gem from './installers/gem'

export default {
  start: async () => {
    try {
      const tasks = new Listr([init, brew, yarn, zsh, iterm2, cask, gem], {
        // @ts-ignore
        collapse: false,
        exitOnError: false,
      })
      await tasks.run()
    } catch (err) {
      const errors = err.errors.map((e: Error) => e.message)
      const errorsPath = path.join(os.homedir(), 'Desktop/dotfiles-error.log')

      if (errors.length > 0) {
        fs.writeFileSync(
          errorsPath,
          errors.join('\n\n-------------\n\n').concat('\n'),
        )
        console.log('\n')
        consola.info('Some modules are not installed properly.')
        consola.info(`See: ${chalk.cyan(errorsPath)}`)
      }
    } finally {
      await git.setup()

      console.log('\n')
      consola.success('The installations has finished!')
      consola.success('Please restart your Mac for changes to take effect\n')

      await execa.command(
        'open -a "Google Chrome" "https://github.com/kykungz/dotfiles/blob/master/ADDITIONAL_STEPS.md"',
        { shell: true },
      )
    }
  },
}
