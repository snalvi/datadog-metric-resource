FROM ubuntu:xenial AS resource

RUN apt-get update
RUN apt-get -y install --fix-missing \
   bash \
   curl \
   gzip \
   jq \
   tar \
   openssl

ADD cmd/ opt/resource/
RUN chmod +x /opt/resource/*

FROM resource AS tests
RUN apt-get -y install --fix-missing \
 ruby \
 ruby-bundler \
 ruby-json

ADD . /resource
WORKDIR /resource
RUN bundle install
RUN bundle exec rspec

FROM resource
