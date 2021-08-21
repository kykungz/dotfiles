type Values = {
  brew: string[]
  yarn: string[]
  cask: string[]
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
    zsh: false,
    iterm2: false,
    git: false,
    password: null,
  }
}

export default new AnswerStore()
