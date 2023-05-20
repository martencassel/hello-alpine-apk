builder:
	docker build -t alpine:builder . -f ./Dockerfile.builder

builder-shell:
	docker rm -f builder||true
	docker run -it --rm --name=builder -v $(shell pwd):/host -w /host alpine:builder sh 
 
