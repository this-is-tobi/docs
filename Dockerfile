# Build stage
FROM docker.io/oven/bun:1.3.14 AS build

RUN apt-get update && apt-get install --yes --no-install-recommends git ca-certificates && update-ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

COPY . .
RUN --mount=type=secret,id=GITHUB_TOKEN \
    bun run build:docs -T "$(cat /run/secrets/GITHUB_TOKEN)"

# Prod stage
FROM docker.io/nginxinc/nginx-unprivileged:1.31-alpine AS prod

USER 0
COPY --from=build --chown=1001:0 --chmod=770 /app/docpress/.vitepress/dist /usr/share/nginx/html/
COPY --chown=1001:0 --chmod=660 ./nginx.conf /etc/nginx/conf.d/default.conf
RUN chmod 660 /etc/nginx/conf.d/default.conf
USER 1001
EXPOSE 8080
