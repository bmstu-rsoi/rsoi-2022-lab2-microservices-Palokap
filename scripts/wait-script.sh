#!/usr/bin/env bash

echo "hello"

IFS="," read -ra PORTS <<<"$WAIT_PORTS"
path=$(dirname "$0")

echo "hello2"
PIDs=()
for port in "${PORTS[@]}"; do
    echo "for1"
  "$path"/wait-for.sh -t 120 "http://localhost:$port/manage/health" -- echo "Host localhost:$port is active" &
  PIDs+=($!)
done

echo "hello3"
for pid in "${PIDs[@]}"; do
  if ! wait "${pid}"; then
    exit 1
  fi
done
echo "hello4"
