FROM test_parent

RUN mkdir -p /usr/src/app

WORKDIR /usr/src

COPY package.json package.json

RUN npm install tail
RUN npm install

WORKDIR /usr/src/app

RUN npm link oracledb
COPY . .
