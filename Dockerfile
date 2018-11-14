FROM node:10-alpine

RUN apk --no-cache add curl \
    && curl -sL https://github.com/openfaas/faas/releases/download/0.9.6/fwatchdog > /usr/bin/fwatchdog \
    && apk del curl \
    && chmod +x /usr/bin/fwatchdog

COPY *.js ./
COPY package.json .
RUN npm i

# Define your binary here
ENV fprocess="/usr/local/bin/node index.js"
ENV content_type="application/json"

CMD ["fwatchdog"]
