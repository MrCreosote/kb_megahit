FROM kbase/kbase:sdkbase.latest
MAINTAINER Michael Sneddon
# -----------------------------------------

WORKDIR /kb/module

RUN pip install cffi --upgrade \
    && pip install pyopenssl --upgrade \
    && pip install ndg-httpsclient --upgrade \
    && pip install pyasn1 --upgrade \
    && pip install requests --upgrade \
    && pip install 'requests[security]' --upgrade

# Install MEGAHIT
RUN \
  git clone https://github.com/voutcn/megahit.git && \
  cd megahit && \
  git checkout tags/v1.1.1 && \
  make

# copy local wrapper files, and build
COPY ./ /kb/module
RUN mkdir -p /kb/module/work
RUN chmod -R a+rw /kb/module

WORKDIR /kb/module

RUN make all

ENTRYPOINT [ "./scripts/entrypoint.sh" ]

CMD [ ]
