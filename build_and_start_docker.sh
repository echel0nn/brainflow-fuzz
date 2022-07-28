#!/usr/bin/env bash

docker build -t brainflow . && 
	docker run -dit --rm --cap-add=SYS_PTRACE --name brainflow --hostname brainflow --mount type=tmpfs,destination=/ramdisk -e AFL_TMPDIR=/ramdisk brainflow /bin/bash &&
	docker exec -ti brainflow /bin/bash
