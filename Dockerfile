ARG ARCH
FROM deepquestai/deepstack:${ARCH}
RUN apt install -y jq
COPY docker-entrypoint.sh /tmp/entrypoint.sh
ENTRYPOINT [ "sh", "/tmp/entrypoint.sh" ]