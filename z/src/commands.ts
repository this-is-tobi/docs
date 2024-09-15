import path from 'node:path'
import { generateDoc, getUserRepos, initProvider } from './github.ts'
import { options, type Options } from './schemas.ts'
import { createDir } from './utils.ts'

export async function main(opts: Options) {
  const { username, repositories: reposFilter, token } = options.parse(opts)

  initProvider(token)

  const repositories = await getUserRepos(username, reposFilter)

  repositories.forEach(async (repo) => {
    createDir(path.resolve(__dirname, `projects/${repo.name}`))

    await generateDoc(username, repo.name)
  })
}
