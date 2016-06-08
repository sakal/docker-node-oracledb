FROM nodeoracledb_parent

RUN mkdir -p /usr/src/app

WORKDIR /usr/src

COPY package.json package.json

RUN npm install -g wait-on && npm install

WORKDIR /usr/src/app

COPY . .
