import Listr from 'listr'
import chalk from 'chalk'

import execute from '../utils/execute'

export default {
  title: chalk.bold('Fonts'),
  task: () =>
    new Listr([
      {
        title: 'Downloading fonts',
        task: () =>
          execute(
            'git clone https://github.com/powerline/fonts.git ~/fonts --depth=1',
          ),
      },
      {
        title: 'Installing fonts',
        task: () => execute('~/fonts/install.sh && rm -rf ~/fonts'),
      },
    ]),
}
