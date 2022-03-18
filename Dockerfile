FROM ruby:2.6
RUN gem install bundler -v'2.2.5'
COPY ./Gemfile* ./
RUN bundle install
COPY . .