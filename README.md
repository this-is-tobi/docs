# Doc generator :robot:

This project aims to automate the construction of documentation website based on a list of repositories.

## Explanation

The [script](./scripts/sync.sh) will download the documentation files for the given repository list, to do this it will check if a `docs/` folder is present at root level and download this entire folder or only the `README.md` file if this is not the case.
After downloading all project documentation files, it will build a static website using [vitepress](https://vitepress.dev/).

> If a `docs/` folder is present, all files in it will be sorted and renamed without the prefix number so it will not appeared inside the generated website. Example: `01-get-started.md` will become `get-started.md`.

## Automation

The script runs in a [workflow](./.github/workflows/sync.yml) every week (Sunday - 03:00 am) or can be triggered manually from the Github user interface.

In addition, after each workflow run, images older than 30 days will be deleted and the newly created container will be deployed.

## Prerequisites

To run the shell script that build the static website, install :
- [jq](https://jqlang.github.io/jq/) *- json parser.*
- [yq](https://github.com/mikefarah/yq) *- yaml parser.*

To run the application in development mode, install :
- [nodejs](https://nodejs.org/) *- javascript runtime.*
- [pnpm](https://pnpm.io/) *- powerful, space efficient node package manager.*

## Development

1. Change user and repositories in the [shell script](./scripts/sync.sh).
2. Run the shell script. 
    ```sh
    sh ./scripts/sync.sh
    ```
4. Install project nodejs dependencies.
    ```sh
    pnpm install
    ```
5. Launch dev mode.
    ```sh
    pnpm run dev
    ```

## Rules

It is important to understand and respect some conventions for the script to work correctly :
- Only the `docs/` root folder in the repository will be parsed to import advanced documentation (multi pages documentation, embed images or files, etc...).
- The `README.md` root file will only be imported if there is no `./docs/01-readme.md` file (this allows you to manage differences between the readme file and the advanced documentation introduction page, for example using a table of contents in the readme file that makes no sense in the documentation website).
- Any inline link in the `README.md` root file that does not point to `./docs/**` will be replaced by the appropriate Github link.
- Each project description on the home page is extracted from the Github repository description.
<!-- - Each project badge is fetched from the Github repository topics (https://docs.github.com/fr/rest/repos/repos?apiVersion=2022-11-28#get-all-repository-topics). -->