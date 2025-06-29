# Prod stage
FROM docker.io/nginxinc/nginx-unprivileged:1.28.0-alpine AS prod

USER 0
COPY --chown=1001:0 --chmod=770 ./docpress/.vitepress/dist /usr/share/nginx/html/
COPY --chown=1001:0 --chmod=660 ./nginx.conf /etc/nginx/conf.d/default.conf
RUN chmod 660 /etc/nginx/conf.d/default.conf
USER 1001
EXPOSE 8080
