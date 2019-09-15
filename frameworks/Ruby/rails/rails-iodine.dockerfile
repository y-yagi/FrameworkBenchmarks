FROM ruby:2.6

ADD ./ /rails

WORKDIR /rails

RUN gem install bundler
RUN bundle install --jobs=4 --gemfile=/rails/Gemfile --path=/rails/rails/bundle --without postgresql

CMD DB_HOST=tfb-database RACK_ENV=production_mysql bundle exec iodine -b 0.0.0.0 -p 8080
