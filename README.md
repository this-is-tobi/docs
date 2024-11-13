# Doc generator :robot:

This project aims to automate the construction of documentation website based on [docpress](https://github.com/this-is-tobi/docpress) package.

## Automation

The build and deploy [workflow](./.github/workflows/sync.yml) runs every week (Sunday - 03:00 am) or can be triggered manually from the Github user interface.

> [!TIP]
> The workflow can be triggered by CLI with correct permissions using the following command : `gh workflow run .github/workflows/sync.yml --repo this-is-tobi/docs --ref main`

In addition, after each workflow run, images older than 30 days will be deleted and the newly created container will be deployed.

## Prerequisites

To run the application in development mode, install :
- [docker](https://www.docker.com) *- container runtime.*
- [nodejs](https://nodejs.org/) *- javascript runtime.*
- [pnpm](https://pnpm.io/) *- powerful, space efficient node package manager.*

## Development

1. Update [docpress config file](./docpress.config.json).
2. Install project nodejs dependencies.
    ```sh
    pnpm install
    ```
3. Build website. 
    ```sh
    pnpm run build
    ```
4. Launch app container on port `8080`.
    ```sh
    pnpm run start
    ```
