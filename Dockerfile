FROM ubuntu:14.04

ENV PUPPET_SERVER_VERSION="2.4.0" DUMB_INIT_VERSION="1.0.2" UBUNTU_CODENAME="trusty" PUPPETSERVER_JAVA_ARGS="-Xms256m -Xmx256m" PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH

RUN apt-get update && \
    apt-get install -y wget=1.17.1-1ubuntu1 && \
    wget https://apt.puppetlabs.com/puppetlabs-release-pc1-"$UBUNTU_CODENAME".deb && \
    wget https://github.com/Yelp/dumb-init/releases/download/v"$DUMB_INIT_VERSION"/dumb-init_"$DUMB_INIT_VERSION"_amd64.deb && \
    dpkg -i puppetlabs-release-pc1-"$UBUNTU_CODENAME".deb && \
    dpkg -i dumb-init_"$DUMB_INIT_VERSION"_amd64.deb && \
    rm puppetlabs-release-pc1-"$UBUNTU_CODENAME".deb dumb-init_"$DUMB_INIT_VERSION"_amd64.deb && \
    apt-get update && \
    apt-get install --no-install-recommends -y puppetserver="$PUPPET_SERVER_VERSION"-1puppetlabs1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY puppetserver /etc/default/puppetserver
COPY logback.xml /etc/puppetlabs/puppetserver/
COPY request-logging.xml /etc/puppetlabs/puppetserver/

RUN puppet config set autosign true --section master

VOLUME /etc/puppetlabs/code/

COPY docker-entrypoint.sh /

EXPOSE 8140

ENTRYPOINT ["dumb-init", "/docker-entrypoint.sh"]
CMD ["foreground" ]

COPY Dockerfile /
