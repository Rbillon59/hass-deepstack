FROM deepquestai/deepstack:arm64-2022.01.1
RUN apt install -y jq
COPY docker-entrypoint.sh /tmp/entrypoint.sh
ENTRYPOINT [ "sh", "/tmp/entrypoint.sh" ]
