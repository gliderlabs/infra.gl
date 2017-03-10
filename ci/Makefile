.PHONY: test build push

push: build
	docker push gliderlabs/ci:latest

build:
	docker build -t gliderlabs/ci:latest .

test:
	circleci-builder build --config circle.test.yml -v $(shell pwd):/src
