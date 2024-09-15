import type { Options } from './schemas.ts'
import fs from 'node:fs'
import { basename, dirname, parse, resolve } from 'node:path'
import { Octokit } from 'octokit'
import { capitalize } from './utils.ts'

let octokit: Octokit

export function initProvider(token?: Options['token']) {
  octokit = new Octokit({ auth: token })
}

export async function getUserRepos(username: Options['username'], repoList: Options['repositories']) {
  const { data } = (await octokit.request('GET /users/{username}/repos', { username, sort: 'full_name' }))

  if (repoList) {
    return data.filter(repo => repoList?.some(filter => filter === repo.name))
  }
  return data.filter(repo => !repo.fork)
}

export async function generateDoc(owner: Options['username'], repo: string, branch?: Options['branch']) {
  const hasDocFolder = await getDocs(owner, repo, 'docs', branch)

  if (!hasDocFolder) {
    await getDocs(owner, repo, 'README.md', branch)
  }
}

async function getDocs(owner: Options['username'], repoName: string, path: string, branch?: Options['branch']) {
  try {
    const { data } = await octokit.request('GET /repos/{owner}/{repo}/contents/{path}', { owner, repo: repoName, path, ref: branch })

    const resources = Array.isArray(data) ? data.flat() : [data]

    for (const resource of resources) {
      if (resource.type === 'file') {
        const { data: resourceDetail } = await octokit.request('GET /repos/{owner}/{repo}/contents/{path}', { owner, repo: repoName, path: resource.path, ref: branch })
        const resourceDir = dirname(resourceDetail.path.split('/').slice(1).join('/'))
        const resourceFile = basename(resourceDetail.path).toLocaleLowerCase().replace(/^\d{2}-/, '')

        fs.mkdirSync(resolve(__dirname, `projects/${repoName}/${resourceDir}`), { recursive: true })
        fs.writeFileSync(resolve(__dirname, `projects/${repoName}/${resourceDir}/${resourceFile}`), atob(resourceDetail.content).replace(/\[([\s\S]+)\]\(\.\.\/(.+?)\)/g, `[$1](https://github.com/${owner}/${repoName}/tree/${branch}/$2)`), {})

        const regex = /\[([\s\S]+?)\]\(\.\.\/(.+?)\)/g
        let match
        while ((match = regex.exec(atob(resourceDetail.content))) !== null) {
          console.log('Texte du lien :', match[1]) // Texte entre crochets
          console.log('Chemin relatif :', match[2]) // Chemin après ../
        }

        if (resource.name.endsWith('.md')) {
          const text = capitalize(parse(resourceFile).name.replace('-', ' '))
          const content = {
            text: text === 'Readme' ? 'Introduction' : text,
            link: `/${repoName}/${parse(resourceFile).name}`,
          }

          try {
            const config = JSON.parse(fs.readFileSync(resolve(__dirname, `projects/${repoName}/config.json`), 'utf8'))
            fs.writeFileSync(resolve(__dirname, `projects/${repoName}/config.json`), JSON.stringify([...config, content], null, 2))
          } catch (_e) {
            // console.log(_e)
            fs.writeFileSync(resolve(__dirname, `projects/${repoName}/config.json`), JSON.stringify([content], null, 2))
          }
        }
      } else if (resource.type === 'dir') {
        await getDocs(owner, repoName, resource.path, branch)
      }
    }
    return true
  } catch (_e) {
    // console.log(_e)
    return false
  }
}
