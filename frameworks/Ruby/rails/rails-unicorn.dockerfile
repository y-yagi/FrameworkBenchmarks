FROM ruby:2.6

RUN apt update -yqq && apt install -yqq nginx

ADD ./ /rails

WORKDIR /rails

RUN gem install bundler
RUN bundle install --jobs=4 --gemfile=/rails/Gemfile --path=/rails/rails/bundle --without=postgresql

CMD nginx -c /rails/config/nginx.conf && \
  DB_HOST=tfb-database bundle exec unicorn_rails -E production_mysql -c config/unicorn.rb
