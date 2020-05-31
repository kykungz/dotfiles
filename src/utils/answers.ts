type Values = {
  brew: string[]
  yarn: string[]
  cask: string[]
  gem: string[]
  zsh: boolean
  iterm2: boolean
  git: boolean
  password: string
}

class AnswerStore {
  public values: Values = {
    brew: [],
    yarn: [],
    cask: [],
    gem: [],
    zsh: false,
    iterm2: false,
    git: false,
    password: null,
  }
}

export default new AnswerStore()
