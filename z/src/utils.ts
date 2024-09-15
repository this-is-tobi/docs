import fs from 'node:fs'

export function prettifyEnum(arr: readonly string[]) {
  return arr.reduce((acc, cur, idx, arr) => {
    if (!idx) {
      return cur
    } else if (idx === arr.length - 1) {
      return `${JSON.stringify(acc)} or ${JSON.stringify(cur)}`
    } else {
      return `${JSON.stringify(acc)}, ${JSON.stringify(cur)}`
    }
  }, '')
}

export function createDir(folderName: string) {
  try {
    if (fs.existsSync(folderName)) {
      fs.rmSync(folderName, { recursive: true })
    }
    fs.mkdirSync(folderName)
  } catch (err) {
    console.error(err)
  }
}

export function capitalize(s: string) {
  return (s && s[0].toUpperCase() + s.slice(1).toLowerCase()) || ''
}
