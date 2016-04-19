
.PHONY: build test release

QUAY_URL	:= quay.io/byuoit/node-oracledb
VERSION		:= 4.4-1.8
TAG		:= $(VERSION)-$(shell git rev-parse --short --verify HEAD)

all: get-client build test release clean

get-client:
	wget -c https://github.com/byu-oit-appdev/docker-node-oracledb/blob/binaries/oracle-instantclient-12.1.tgz

build:
	docker build -t $(TAG) --force-rm .

exec:
	docker run --rm -it $(TAG) /bin/bash
	
test:
	docker inspect $(TAG)
#  'invalid username/password logon denied' is ora-01017 is the desired error message, we should not be able to check the creds without TNS setup correctly.	

release:
	docker tag  $(TAG) $(QUAY_URL):$(TAG)
	docker tag  $(QUAY_URL):$(TAG) $(QUAY_URL):latest

	docker push $(QUAY_URL):$(TAG)
	docker push $(QUAY_URL):latest
	
clean:
	-rm oracle-instantclient-*.tgz
