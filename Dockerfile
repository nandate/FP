FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN gem install bundler

RUN gem install bundler
WORKDIR /tmp

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install
ENV APP_HOME /app_name
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME
