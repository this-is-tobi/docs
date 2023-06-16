# Doc generator :robot:

This project aims to automate the construction of documents from a list of repositories.

## Explanation

The [script](./scripts/sync.sh) will download the documentation files for the given repository list, to do this it will check if a `docs/` folder is present at root level and download this entire folder or only the `README.md` file if this is not the case.
After downloading all project documentation files, it will build a static website using [vitepress](https://vitepress.dev/).

> If a `docs/` folder is present, all files in it will be sorted and renamed without the prefix number so it will not appeared inside the generated website. Example: `01-get-started.md` will become `get-started.md`.

## Automation

The script runs in a [workflow](./.github/workflows/sync.yml) every week (Sunday - 03:00 am) or can be triggered manually from the Github user interface.
