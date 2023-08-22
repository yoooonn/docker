FROM openanolis/anolisos:8
LABEL authors="yooonn"

RUN echo -e "\n# Aliases\nalias l='ls -alh'\n" >> $HOME/.bashrc

RUN yum update -y \
    && yum install -y yum-utils \
    && yum-config-manager --enable Plus

RUN yum install -y java-1.8.0-alibaba-dragonwell-headless-fastdebug.aarch64

ENV JAVA_HOME="/usr/lib/jvm/java-1.8.0-alibaba-dragonwell-1.8.0.352-2.an8.aarch64-fastdebug/jre"

CMD ["/usr/sbin/init"]
