FROM alpine:latest
RUN apk add --update bash
COPY rancher /usr/local/bin/
COPY entrypoint.sh /
ENV INTERVAL=300
ENTRYPOINT /entrypoint.sh
