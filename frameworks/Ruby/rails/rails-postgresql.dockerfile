FROM ruby:2.6

ADD ./ /rails

WORKDIR /rails

RUN gem install bundler
RUN bundle install --jobs=4 --gemfile=/rails/Gemfile --path=/rails/rails/bundle --without mysql

ENV DBTYPE=postgresql
CMD DB_HOST=tfb-database bundle exec puma -b tcp://0.0.0.0:8080 -e production_postgresql
