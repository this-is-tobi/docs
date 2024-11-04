# Prod stage
FROM docker.io/bitnami/nginx:1.26.1 AS prod

COPY --chown=1001:0 --chmod=770 ./docpress/.vitepress/dist /opt/bitnami/nginx/html/
COPY --chown=1001:0 --chmod=660 ./nginx.conf /opt/bitnami/nginx/conf/server_blocks/default.conf
USER 1001
EXPOSE 8080
