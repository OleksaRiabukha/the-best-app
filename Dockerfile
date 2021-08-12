FROM ruby:3.0.1

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -yqq && apt-get install -yqq postgresql-client nodejs yarn

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app

RUN gem install bundler
RUN bundle install

COPY . /usr/src/app/
COPY .node_modules/bootstrap-icons /usr/src/app/

COPY ./entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["bin/rails", "s", "-b", "0.0.0.0"]