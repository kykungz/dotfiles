let answers = {
  brew: [],
  yarn: [],
  cask: [],
  gem: [],
  git: false,
  iterm2: false,
  password: null,
}

export default {
  get: () => answers,
  set: (newAnswers) => {
    answers = newAnswers
  },
}
