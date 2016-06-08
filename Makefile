
.PHONY: build test release

QUAY_URL	:= quay.io/byuoit/node-oracledb
VERSION		:= 4.4-1.8
TAG		:= $(VERSION)-$(shell git rev-parse --short --verify HEAD)

all: db_client build test release clean


build: db_client
	docker build -t $(TAG) .


test:
	docker-compose -f test/docker-compose.yml -f test/docker-compose.onpremdb.yml up || [ $$? -eq v ]


release:
	docker tag  $(TAG) $(QUAY_URL):$(TAG)
	docker tag  $(QUAY_URL):$(TAG) $(QUAY_URL):latest

	docker push $(QUAY_URL):$(TAG)
	docker push $(QUAY_URL):latest


clean:
	-rm oracle-instantclient-*.tgz


merge:
	git merge master
	git checkout master
	git merge --no-ff --no-edit
	git push


pq:
	curl -fsSL https://get.docker.com/ | sh
	docker run hello-world

	curl -L https://github.com/docker/compose/releases/download/1.7.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
	docker-compose version


db_client:
	wget -c https://github.com/byu-oit-appdev/docker-node-oracledb/blob/binaries/oracle-instantclient-12.1.tgz
