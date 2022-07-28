#!/usr/bin/env bash
afl-fuzz -D -L0 -i samples/ -t 80 -o sync_dir -M fuzzer00 -- ./harness @@
