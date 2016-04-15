
.PHONY: update build test release

DOCKERCMD	:= docker
DOCKER_REPO_URL	:= quay.io/byuoit/node-oracledb
VERSION		:= 4.4-1.8
TAG		:= $(VERSION)-$(shell git rev-parse --short --verify HEAD)

all: build test release


build:
	$(DOCKERCMD) build -t $(TAG) --force-rm .

exec:
	$(DOCKERCMD) run --rm -it $(TAG) /bin/bash
	
test:
	$(DOCKERCMD) inspect $(TAG)
	cd test && ./child-image.sh $(TAG); cd ..


release:
	$(DOCKERCMD) tag  $(TAG) $(DOCKER_REPO_URL):$(TAG)
	$(DOCKERCMD) tag  $(DOCKER_REPO_URL):$(TAG) $(DOCKER_REPO_URL):latest

	$(DOCKERCMD) push $(DOCKER_REPO_URL):$(TAG)
	$(DOCKERCMD) push $(DOCKER_REPO_URL):latest
