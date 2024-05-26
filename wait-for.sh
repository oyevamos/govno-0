#!/bin/sh

# original script: https://github.com/eficode/wait-for

set -e

TIMEOUT=60
QUIET=0
STRICT=0
HOST=""
PORT=""

print_usage() {
  echo "Usage: wait-for.sh host:port [-s] [-t timeout] [-- command args]"
  echo "       -s | --strict    Only execute subcommand if the test succeeds"
  echo "       -q | --quiet     Don't output any status messages"
  echo "       -t TIMEOUT       Timeout in seconds, zero for no timeout"
  echo "       -- COMMAND ARGS  Execute command with args after the test finishes"
  exit 1
}

while [ "$1" != "" ]; do
  case "$1" in
    *:* )
    HOST=$(echo "$1" | cut -d: -f1)
    PORT=$(echo "$1" | cut -d: -f2)
    shift 1
    ;;
    -h )
    print_usage
    ;;
    -q | --quiet)
    QUIET=1
    shift 1
    ;;
    -s | --strict)
    STRICT=1
    shift 1
    ;;
    -t )
    TIMEOUT="$2"
    if [ "$TIMEOUT" = "" ]; then
      break
    fi
    shift 2
    ;;
    --)
    shift
    break
    ;;
    *)
    echo "Unknown argument: $1"
    print_usage
    ;;
  esac
done

if [ "$HOST" = "" ] || [ "$PORT" = "" ]; then
  echo "Error: you need to provide a host and port to test."
  print_usage
fi

WAITFORIT_cmd=$(cat << EOF
timeout $TIMEOUT sh -c 'until echo > /dev/tcp/$HOST/$PORT; do sleep 0.1; done'
EOF
)

if [ $QUIET -eq 1 ]; then
  WAITFORIT_cmd="$WAITFORIT_cmd >/dev/null 2>&1"
fi

eval "$WAITFORIT_cmd"

if [ $? -ne 0 ]; then
  if [ $STRICT -eq 1 ]; then
    echo "wait-for: timeout occurred after waiting $TIMEOUT seconds for $HOST:$PORT."
    exit 1
  else
    echo "wait-for: timeout occurred after waiting $TIMEOUT seconds for $HOST:$PORT."
  fi
fi

if [ "$*" != "" ]; then
  exec "$@"
else
  exit 0
fi
