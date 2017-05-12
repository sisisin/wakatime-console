FROM ruby:2.3.1

ENV APP_ROOT /usr/src/app
WORKDIR $APP_ROOT

ADD Gemfile Gemfile.lock $APP_ROOT/
RUN bundle install
ADD . $APP_ROOT
RUN bin/rails assets:precompile

EXPOSE  3000
