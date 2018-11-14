# poc-fast-watchdog-docker

A POC to try faas-watchdong inside a docker container to run a serverless function.


## Description

If you have troubles getting started with [OpenFaaS](https://github.com/openfaas/faas) and want to try a quick and dirty serverless function you can use this setup. 

The idea is to only use [OpenFaaS Watchdog function](https://github.com/openfaas/faas/tree/master/watchdog) to fork and run your process/function.


## Setup and build

You just need `docker` installed. Then run: 

```
docker build -t poc-watchdog .
```

And start your container:

```
docker run -it -p4000 --rm poc-watchdog
```

## Usage

Once your container is running, send traffic to it with curl:


```
curl -XPOST -d '{ "test": 1234 }' http://localhost:4000/
# Output
{
  "env": {
    "PATH": "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    "HOSTNAME": "645f70c25bc2",
    "TERM": "xterm",
    "NODE_VERSION": "10.12.0",
    "YARN_VERSION": "1.10.1",
    "fprocess": "/usr/local/bin/node index.js",
    "content_type": "application/json",
    "HOME": "/root",
    "Http_User_Agent": "curl/7.58.0",
    "Http_Accept": "*/*",
    "Http_Content_Length": "16",
    "Http_Content_Type": "application/x-www-form-urlencoded",
    "Http_Method": "POST",
    "Http_ContentLength": "16",
    "Http_Path": "/",
    "Http_Host": "localhost:4000"
  },
  "context": {
    "body": {
      "test": 1234
    }
  }
}
```


## Development 

You can try the function locally by redirecting content through pipes:

```
cat example_body.json | node index.js
```

Edit `handler.js` to do any process you need.


## Caveats

- *Its slow in comparison to a server*: Each time you call it, the `watchdog` fork a process and start `node`. If you are ok with response times of 0.10s instead of ms, go for it.
- *Not suitable for all kind of inputs*: Content is sent to your process through `process.stdin`, the parser is painfully simple.
- *Any output is part of the response*: Take care of what you output to the console, because all is part of the response.

