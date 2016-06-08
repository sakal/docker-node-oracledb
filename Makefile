
.PHONY: build test release

QUAY_URL	:= quay.io/byuoit/node-oracledb
VERSION		:= 4.4-1.8
TAG		:= $(VERSION)-$(shell git rev-parse --short --verify HEAD)

all: db_client build test release clean

build: db_client
	@docker-compose build || (echo "dc build failed $$?"; exit 1)

test:
# 	$(eval $@_DC_OUT := $(shell docker-compose up -d && docker-compose run --rm child; echo $? ))
# 	echo  $($@_DC_OUT)
	docker-compose up -d && docker-compose run --rm child
	
# 	|| (echo "db test failed $$?"; exit 1)
# 	
# 	
# 	command || [ $$? -eq v ]




test_on_prem:
	docker-compose -f docker-compose.yml -f docker-compose.onpremdb.yml up
#  'invalid username/password logon denied' is ora-01017 is the desired error message, we should not be able to check the creds without TNS setup correctly.	
	


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
	
pq:
	curl -fsSL https://get.docker.com/ | sh
	docker run hello-world
	
	curl -L https://github.com/docker/compose/releases/download/1.7.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
	docker-compose version
	
db_client:
	wget -c https://github.com/byu-oit-appdev/docker-node-oracledb/blob/binaries/oracle-instantclient-12.1.tgz