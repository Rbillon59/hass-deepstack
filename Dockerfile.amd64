FROM deepquestai/deepstack:cpu
RUN apt install -y jq
COPY docker-entrypoint.sh /tmp/entrypoint.sh
ENTRYPOINT [ "sh", "/tmp/entrypoint.sh" ]