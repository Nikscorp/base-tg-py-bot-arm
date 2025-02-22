FROM arm32v7/python:3-alpine

COPY --from=hypriot/rpi-alpine /usr/bin/qemu-arm-static /usr/bin/qemu-arm-static

RUN set -e; \
  apk update \
  && apk add gcc make python3-dev musl-dev git libffi-dev \
  && apk del libressl-dev \
  && apk add openssl-dev \
  && pip install cryptography==2.7 \
  && apk del openssl-dev \
  && apk add libressl-dev

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

CMD [ "python" ]
