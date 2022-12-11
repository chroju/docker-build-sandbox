# syntax=docker/dockerfile:1
FROM ubuntu:latest
RUN groupadd -g 1000 example && \
    useradd -m -s /bin/bash -u 1000 -g 1000 example

COPY $GITHUB_WORKSPACE/test /tmp/
USER example
COPY $GITHUB_WORKSPACE/test /tmp/

COPY --chmod=755 <<EOF /app/run.sh
#!/bin/sh
while true; do
  echo -ne "The time is now $(date +%T)\\r"
  sleep 1
done
EOF

ENTRYPOINT /app/run.sh
