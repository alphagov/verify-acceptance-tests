FROM ruby:2.6.6 as bundler

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install


FROM ruby:2.6.6

RUN apt-get update && apt-get install --no-install-recommends -y libxml2 libxslt1.1

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY --from=bundler /usr/local/bundle/ /usr/local/bundle/

COPY features /features

ENTRYPOINT ["bundle", "exec", "parallel_cucumber", "features/"]
