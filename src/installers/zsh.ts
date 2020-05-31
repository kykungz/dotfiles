import { Observable } from 'rxjs'
import Listr, { ListrTask } from 'listr'
import path from 'path'
import chalk from 'chalk'
import fs from 'fs'
import os from 'os'
import execa from 'execa'

import execute from '../utils/execute'
import fonts from './fonts'
import answers from '../utils/answers'
import pathPrefix from '../utils/pathPrefix'

const task: ListrTask = {
  title: chalk.bold('Z Shell'),
  skip: () => !answers.values.zsh,
  task: () => {
    return new Listr([
      {
        title: `Installing ${chalk.cyan.bold('Oh My Zsh')}`,
        task: (_, task) =>
          new Observable((observer) => {
            const process = execa.command(
              `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`,
              { shell: true },
            )

            process.stdout
              .on('data', (chunk) => observer.next(chunk.toString()))
              .on('close', () => observer.complete())

            process.catch(() => task.skip('Oh My Zsh is already installed'))
          }),
      },
      {
        title: `Creating ${chalk.cyan.bold('.zshrc')}`,
        task: () =>
          new Observable((observer) => {
            observer.next('Merging configurations')
            const base = fs
              .readFileSync(
                path.join(__dirname, pathPrefix, 'configs/.zshrc-base'),
              )
              .toString()

            const aliases = fs
              .readFileSync(
                path.join(__dirname, pathPrefix, 'configs/.zshrc-aliases'),
              )
              .toString()

            const functions = fs
              .readFileSync(
                path.join(__dirname, pathPrefix, 'configs/.zshrc-functions'),
              )
              .toString()

            const scripts = fs
              .readFileSync(
                path.join(__dirname, pathPrefix, 'configs/.zshrc-scripts'),
              )
              .toString()

            fs.writeFileSync(
              path.join(os.homedir(), '.zshrc'),
              [base, aliases, functions, scripts].join('\n'),
            )

            observer.complete()
          }),
      },
      {
        title: 'Installing oh-my-zsh Themes',
        task: () => {
          const source = path.join(__dirname, pathPrefix, 'configs/themes')
          return execute(`cp -R -f ${source} ~/.oh-my-zsh/custom`)
        },
      },
      {
        title: 'Installing oh-my-zsh Plugins',
        task: () =>
          new Listr(
            [
              {
                title: 'zsh-syntax-highlighting',
                task: () =>
                  execute(
                    'git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting',
                  ),
              },
              {
                title: 'zsh-completions',
                task: () =>
                  execute(
                    'git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions',
                  ),
              },
              {
                title: 'zsh-autosuggestions',
                task: () =>
                  execute(
                    'git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions',
                  ),
              },
            ],
            { concurrent: true },
          ),
      },
      {
        title: 'Apply macOS Catalina fixes',
        task: () => execute('compaudit | xargs chmod g-w,o-w'),
      },
      {
        title: `Apply ${chalk.cyan.bold('Terminal')} settings`,
        task: () => {
          const plistPath = path.join(
            __dirname,
            pathPrefix,
            'configs/com.apple.Terminal.plist',
          )

          return execute(
            `cp -f ${plistPath} ~/Library/Preferences/ && defaults read ~/Library/Preferences/com.apple.Terminal.plist`,
          )
        },
      },
      { ...fonts, title: 'Installing fonts' },
    ])
  },
}

export default task
