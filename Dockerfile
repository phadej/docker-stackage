FROM       haskell
MAINTAINER Oleg Grenrus <oleg.grenrus@iki.fi>

## Default config
ENV CABALCONFIG /root/.cabal/config
RUN mkdir -p /root/.cabal && \
  echo "remote-repo: stackage-lts-1.7:http://www.stackage.org/snapshot/lts-1.7" >> $CABALCONFIG && \
  echo "remote-repo-cache: /root/.cabal/packages" >> $CABALCONFIG && \
  echo "extra-prog-path: /root/.cabal/bin" >> $CABALCONFIG && \
  echo "build-summary: /root/.cabal/logs/build.log" >> $CABALCONFIG && \
  echo "library-profiling: False" >> $CABALCONFIG && \
  echo "documentation: False" >> $CABALCONFIG

## Update cabal database
RUN cabal update

## Install some packages
RUN cabal install -j4 lens warp aeson
