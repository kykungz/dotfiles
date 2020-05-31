import { Observable } from 'rxjs'
import execa from 'execa'

export default (command: string) => {
  return new Observable<any>((observer) => {
    const process = execa.command(command, { shell: true })

    process.stdout
      .on('data', (chunk) => observer.next(chunk.toString()))
      .on('close', () => observer.complete())

    process.catch((err) =>
      observer.error(new Error(`"${command}"\n\n${err.stderr}`)),
    )
  })
}
