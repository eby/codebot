FROM ruby:3.2-slim

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy dependency files first for layer caching
COPY Gemfile Gemfile.lock codebot.gemspec ./
COPY lib/codebot/metadata.rb lib/codebot/metadata.rb

RUN bundle config set --local without development \
    && bundle install

COPY lib/ lib/
COPY exe/ exe/

# Mount /codebot.yml (or a directory containing it) to persist config
VOLUME ["/codebot.yml"]

# Must bind to 0.0.0.0 inside container; override port with CODEBOT_PORT
ENV CODEBOT_BIND=0.0.0.0

EXPOSE 4567

ENTRYPOINT ["bundle", "exec", "exe/codebot", "--config", "/codebot.yml"]
CMD ["core", "interactive"]
