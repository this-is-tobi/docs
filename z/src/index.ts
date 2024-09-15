import { program } from 'commander'
import { version } from '../package.json'
import { main } from './commands.ts'
import { options } from './schemas.ts'

program
  .name('doc-generator')
  .description('CLI to build a complete portfolio / doc website faster than light.')
  .option(
    '-b, --branch <string>',
    options.shape.branch._def.description,
    options.shape.branch._def.defaultValue(),
  )
  .option(
    '-p, --provider <string>',
    options.shape.provider._def.description,
    options.shape.provider._def.defaultValue(),
  )
  .option(
    '-r, --repositories <string>',
    options.shape.repositories._def.description,
  )
  .option(
    '-t, --token <string>',
    options.shape.token._def.description,
  )
  .option(
    '-u, --username <string>',
    options.shape.username._def.description,
  )
  .version(`${version}`)
  .action(main)

program.parse()
