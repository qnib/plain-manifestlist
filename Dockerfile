FROM alpine:latest
ARG PLATFORM_FEATURES=test

LABEL platform.features=${PLATFORM_FEATURES}
COPY bin/entry.sh /usr/bin/entry.sh
CMD ["/usr/bin/entry.sh"]
ENV SKIP_ENTRYPOINTS=true
ENV PLATFORM_FEATURES=${PLATFORM_FEATURES}
