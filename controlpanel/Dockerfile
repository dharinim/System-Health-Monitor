FROM ruby:2.2.7-slim

WORKDIR /app

ADD . /app

RUN apt-get update && apt-get install -y \
  build-essential \
  patch \
  ruby-dev \
  zlib1g-dev \
  liblzma-dev \
  libsqlite3-dev \
  nodejs

RUN gem install rake
RUN bundle install
RUN gem install rails

EXPOSE 80

CMD ["rails", "s", "-p", "1234", "-b", "0.0.0.0"]
