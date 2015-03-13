FROM       phadej/ghc:7.8.4
MAINTAINER Oleg Grenrus <oleg.grenrus@iki.fi>

## Default config
ENV CABALCONFIG /root/.cabal/config

RUN echo "===> Installing stackage LTS-1.11" \
  && cabal update \
  && curl --silent 'http://www.stackage.org/snapshot/lts-1.11/cabal.config?global=true' >> /tmp/stackage.cabal.config \
  && echo "2badb0b27c98ec9be01825b5b9a94e5d3cbe859deca75cbcfbe8bb8917c76b87  /tmp/stackage.cabal.config" | shasum256 -c \
  && cat /tmp/stackage.cabal.config >> $CABALCONFIG \
  && rm -f /tmp/stackage.cabal.config \
  && echo "library-profiling: False" >> $CABALCONFIG \
  && echo "documentation: False" >> $CABALCONFIG

## Install some packages
#
# The selection is arbitrary,
# but I personally use lot's of them
#
# I might consider splitting this into "stackage" and "web-stackage".
RUN echo "===> Installing some packages" \
  && cabal install -j4 \
    SHA \
    aeson \
    conduit-extra \
    entropy \
    lens \
    regex-applicative \
    wai \
    wai-app-static \
    wai-extra \
    warp \
    websockets \
    wreq \
  && echo "Done!"
