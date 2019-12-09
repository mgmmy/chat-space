FROM ruby:latest

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       g++ qt5-default \
                       libqt5webkit5-dev \
                       gstreamer1.0-plugins-base gstreamer1.0-tools \
                       gstreamer1.0-x

ENV APP_ROOT /app
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

# Add bundle entry point to handle bundle cache

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
# Bundle installs with binstubs to our custom /bundle/bin volume path.
# Let system use those stubs.

COPY . /app/
RUN bundle install
