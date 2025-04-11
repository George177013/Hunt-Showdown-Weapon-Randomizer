# syntax=docker/dockerfile:1

# This Dockerfile is designed for production, not development.
# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.4.2
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Rails app lives here
WORKDIR /rails

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips sqlite3 openssl && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set production environment variables and bundler configuration
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# Throw-away build stage to reduce size of the final image
FROM base AS build

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libyaml-dev pkg-config libssl-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Precompile assets for production
# Remove the dummy secret workaround; ensure that your secret is available via credentials or environment
RUN ./bin/rails assets:precompile

# Final stage for app image
FROM base

# Add the necessary directories to PATH
ENV PATH="${BUNDLE_PATH}/bin:/rails/bin:${PATH}"

# Copy built artifacts: gems and application
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Copy SSL configuration
COPY config/ssl /rails/config/ssl

# Copy the entrypoint script into the image
COPY bin rails/bin

COPY config/credentials/production.yml.enc /rails/config/credentials/production.yml.enc
COPY config/credentials/production.key /rails/config/credentials/production.key

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Expose HTTP and HTTPS ports
EXPOSE 80 443

# Start the server via Thruster by default, this can be overwritten at runtime
CMD ["./bin/rails", "server"]
