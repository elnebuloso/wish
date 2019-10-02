FROM alpine:3.10.2

RUN apk --update add \
        ca-certificates \
        curl \
        bash \
        docker \
        docker-compose \
    && rm -rf /var/cache/apk/*

ADD VERSION /VERSION
ADD bin /usr/local/bin
RUN echo "install commands" \
    && find /usr/local/bin -type f -name '*.sh' | while read f; do mv "$f" "${f%.sh}"; done \
    && chmod +x /usr/local/bin/*

ENV WISH_VERBOSE_LEVEL 1
ENV WISH_DOCKER_IMAGES_PULL_ALWAYS yes

ENTRYPOINT ["_container-run"]
CMD ["wish", "--version"]