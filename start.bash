#!/bin/bash

export SECRET_KEY_BASE="$(mix phx.gen.secret)"

# Mix version
#mix phx.server
# Compiled binary
_build/prod/rel/har_surgeon/bin/server