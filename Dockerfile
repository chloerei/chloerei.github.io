FROM ruby:3.1

ENV LANG=C.UTF-8

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle

WORKDIR /app
