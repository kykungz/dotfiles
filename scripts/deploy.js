const execa = require('execa')

execa
  .command(
    `
    yarn build;
    git add dist;
    git commit -m "Bundle files";
    git push origin \`git subtree split --prefix dist master\`:bundle --force
    git reset --hard HEAD~1;
  `,
    { shell: true, stdio: 'inherit' },
  )
