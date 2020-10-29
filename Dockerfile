FROM nginx:alpine

COPY entrypoint.sh /docker-entrypoint.d/reverse-proxy.sh
RUN chmod +x /docker-entrypoint.d/reverse-proxy.sh