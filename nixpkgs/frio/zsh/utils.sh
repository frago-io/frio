#!/bin/bash
RED='\033[0;31m'
#GREEN='\033[32m'
GREEN='\033[38;5;84m'
BLUE='\033[38;5;44m'
ORANGE='\033[38;5;143m'
RESET="\033[0m"
BOLD="\033[1m"

PX=🍓

echoOK () {
  echoG "✓ $1"
}
echoP () {
  echoB "» $1..."
}
echoB () {
  echo -e "${BLUE}$PX $1\033[0m"
}

echoG () {
  echo -e "${GREEN}$PX $1\033[0m"
}
echoR () {
  echo -e "${RED}$PX $1\033[0m"
}

echoError () {
  echoR "✗ $1"
}
