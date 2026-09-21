FROM alpine:3.18

RUN apk add --no-cache \
        bash \
        gzip \
        postgresql15-client \
        aws-cli

ADD ./rootfs/ /

ENTRYPOINT ["/postgres2s3"]
