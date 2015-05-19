FROM       phadej/ghc:7.8.4
MAINTAINER Oleg Grenrus <oleg.grenrus@iki.fi>

## Default config
ENV CABALCONFIG /root/.cabal/config

RUN echo "===> Installing stackage LTS-1.15" \
  && cabal update \
  && curl --silent 'http://www.stackage.org/snapshot/lts-1.15/cabal.config?global=true' >> /tmp/stackage.cabal.config \
  && echo "aa34f151a1574533d9dfa3b910c9332377565c105d267cd3b034e7e8dad96605  /tmp/stackage.cabal.config" | sha256sum -c \
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
