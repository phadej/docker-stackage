FROM       phadej/ghc:7.8.4
MAINTAINER Oleg Grenrus <oleg.grenrus@iki.fi>

## Default config
ENV CABALCONFIG /root/.cabal/config

RUN echo "===> Installing stackage LTS-1.12" \
  && cabal update \
  && curl --silent 'http://www.stackage.org/snapshot/lts-1.12/cabal.config?global=true' >> /tmp/stackage.cabal.config \
  && echo "9ee814c37438d821c9dda9747d3bf255bca05ce7c947b22a8290858160cef021  /tmp/stackage.cabal.config" | sha256sum -c \
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
