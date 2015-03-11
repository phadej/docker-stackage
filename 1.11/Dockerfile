FROM       phadej/ghc:7.8.4
MAINTAINER Oleg Grenrus <oleg.grenrus@iki.fi>

## Default config
ENV CABALCONFIG /root/.cabal/config

RUN echo "===> Installing stackage LTS-1.11" \
  && cabal update \
  && curl --silent 'http://www.stackage.org/snapshot/lts-1.11/cabal.config?global=true' >> $CABALCONFIG \
  && echo "library-profiling: False" >> $CABALCONFIG \
  && echo "documentation: False" >> $CABALCONFIG

## Install some packages
RUN echo "===> Installing some packages" \
  && cabal install -j4 \
    aeson \
    conduit-extra \
    lens \
    wai \
    wai-extra \
    wai-app-static \
    warp \
    wreq \
  && echo "Done!"
