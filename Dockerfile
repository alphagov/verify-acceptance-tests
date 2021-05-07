ARG base_image=ruby:2.6.6
FROM ${base_image} as bundler

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install

FROM ${base_image}

RUN apt-get update && apt-get install --no-install-recommends -y libxml2 libxslt1.1 firefox-esr

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY --from=bundler /usr/local/bundle/ /usr/local/bundle/

COPY features /features

ENTRYPOINT ["bundle", "exec", "parallel_cucumber", "features/"]
