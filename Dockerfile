FROM ruby:2.6.5

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install

COPY features /features

ENTRYPOINT ["bundle", "exec", "parallel_cucumber", "features/"]
