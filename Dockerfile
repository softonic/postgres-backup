FROM alpine:3.22

RUN apk add --no-cache \
        bash \
        gzip \
        postgresql17-client \
        aws-cli

ADD ./rootfs/ /

ENTRYPOINT ["/postgres2s3"]
