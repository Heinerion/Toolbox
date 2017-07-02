#!/usr/bin/env bash
while true; do inotifywait -re modify . && make; done
