FROM kbase/sdkpython:3.8.0
MAINTAINER Danielle Phillips
# -----------------------------------------
# In this section, you can install any system dependencies required
# to run your App.  For instance, you could place an apt-get update or
# install line here, a git checkout to download code, or run any other
# installation scripts.

# RUN apt-get update
RUN apt-get update
RUN apt-get install -y wget
RUN wget -O /usr/bin/bedtools https://github.com/arq5x/bedtools2/releases/download/v2.31.0/bedtools.static
RUN chmod +x /usr/bin/bedtools

# -----------------------------------------
WORKDIR /kb/module
COPY ./requirements.txt /kb/module/requirements.txt
ENV PIP_PROGRESS_BAR=off
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install -e git+https://github.com/kbase-sfa-2021/sfa.git#egg=base

COPY ./ /kb/module
RUN mkdir -p /kb/module/work
RUN chmod -R a+rw /kb/module

RUN make all

ENTRYPOINT [ "./scripts/entrypoint.sh" ]

CMD [ ]
