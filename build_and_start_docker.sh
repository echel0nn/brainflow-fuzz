#!/usr/bin/env bash

docker build -t brainflow . && 
	docker run -dit --rm --cap-add=SYS_PTRACE --name brainoverflow --hostname brainoverflow --mount type=tmpfs,destination=/ramdisk -e AFL_TMPDIR=/ramdisk brainoverflow /bin/bash &&
	docker exec -ti brainoverflow /bin/bash
