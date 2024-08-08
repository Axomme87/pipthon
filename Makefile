SHELL := /bin/bash

IMAGE_NAME := $(shell basename "$(PWD)")
GRP := "nonrootgroup"
USR := "nonrootuser"
PASS := "1234"


hola:
	echo "$(IMAGE_NAME)"

up:
	IMG="$(IMAGE_NAME)" GRP=$(GRP) USR=$(USR) PASS=$(PASS) docker-compose up -d

run:
	docker exec -it "$(IMAGE_NAME)-container" bash

down:
	IMG="$(IMAGE_NAME)" GRP=$(GRP) USR=$(USR) PASS=$(PASS) docker-compose down
