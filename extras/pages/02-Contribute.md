---
title: Contribute
description: How to contribute to my repositories, report a security vulnerability and reuse the code.
sidebar: false
prev: false
next: false
outline: [2, 2]
pageClass: site-page
---

# Contribute

Contributions to my repositories are welcome! They go through GitHub issues and pull requests, following the few rules below.

## Ground rules

<div class="rule-grid">

- **Conventional Commits**
  Commit messages follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification: they drive the changelog and the release versions. The [VSCode extension](https://github.com/vivaxy/vscode-conventional-commits) helps writing them.
- **Rebased branches**
  Rebase your branch on `main`, without merge commits, before asking for a review, and open the pull request against `main`.
- **Green CI**
  Run the repository's linters and tests before pushing and make sure the CI workflows pass. In a tested repository, a new feature comes with its tests.

</div>

## Workflow

1. Fork the repository on GitHub, then clone your fork and track the original repository:
   ```sh
   git clone https://github.com/<your-username>/<repository>.git
   cd <repository>
   git remote add upstream https://github.com/this-is-tobi/<repository>.git
   ```
2. Create a branch for your change:
   ```sh
   git checkout -b feat/my-feature
   ```
3. Commit following the Conventional Commits specification:
   ```sh
   git commit -m "feat: add my feature"
   ```
4. Rebase onto the latest `main` of the original repository:
   ```sh
   git fetch upstream
   git rebase upstream/main
   ```
5. Push to your fork, then open a pull request against `main`:
   ```sh
   git push --force-with-lease origin feat/my-feature
   ```

## Issues

Bugs and feature requests go to the repository's issue tracker, which offers a template for each. Please look for an existing issue first, and give the versions in use and the steps to reproduce a bug.

## Security

::: danger Report vulnerabilities privately
Please do not report security vulnerabilities through public GitHub issues, discussions or pull requests.
:::

Send them by email to <this-is-tobi@proton.me> instead, with as much of the following information as you can, so that the report can be triaged quickly:

- The type of issue (e.g. buffer overflow, SQL injection or cross-site scripting).
- The full paths of the source files related to the issue.
- The location of the affected source code (tag, branch, commit or direct URL).
- Any special configuration required to reproduce the issue.
- Step-by-step instructions to reproduce the issue.
- Proof-of-concept or exploit code, if possible.
- The impact of the issue, including how an attacker might exploit it.

## Code of conduct

Everyone taking part in my repositories is expected to follow the [code of conduct](https://github.com/this-is-tobi/.github/blob/main/CODE_OF_CONDUCT.md).

## License

All my repositories are distributed under the MIT license, unless a repository ships its own license, which then applies.

::: details MIT License

Copyright (c) 2020-present Thibault Colin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

:::
