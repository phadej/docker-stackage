FROM       phadej/ghc:7.8.4
MAINTAINER Oleg Grenrus <oleg.grenrus@iki.fi>

## Default config
ENV CABALCONFIG /root/.cabal/config

RUN echo "===> Installing stackage LTS-2.9" \
  && cabal update \
  && curl --silent 'http://www.stackage.org/snapshot/lts-2.9/cabal.config?global=true' >> /tmp/stackage.cabal.config \
  && echo "0e8774a5f4b29bbc43be2277b1d25acf96f4c94a5d1f90182d17a89072ab7c7e  /tmp/stackage.cabal.config" | sha256sum -c \
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
    MonadRandom \
    QuickCheck \
    SHA \
    aeson \
    arrows \
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
