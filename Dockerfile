FROM ruby:2.7.0

RUN apt update

RUN apt -y install curl gnupg ca-certificates apt-transport-https nodejs

RUN wget https://dl.yarnpkg.com/debian/pubkey.gpg
RUN cat pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update

RUN apt -y install yarn

COPY ./package.json ./package.json
COPY ./Gemfile ./Gemfile

<<<<<<< HEAD
RUN yarn install --no-lockfile  --network-timeout 100000
RUN bundle install
=======
RUN yarn install --no-lockfile --network-timeout 100000
RUN bundle install --jobs `getconf _NPROCESSORS_ONLN`
>>>>>>> 0d45f571db65fc166675a457487dff240b525012

COPY . .

ENV MARIADB_USERNAME=root
ENV MARIADB_PASSWORD=root
ENV MARIADB_ADDRESS=mariadb
ENV REDIS_URL=redis
