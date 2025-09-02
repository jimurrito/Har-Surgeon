#!/bin/bash

docker build -t jimurrito/har-surgeon:test .
docker run -it --rm -p 4000:4000 jimurrito/har-surgeon:test
