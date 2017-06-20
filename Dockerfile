FROM openjdk:8-jdk-alpine

VOLUME /data/services

ADD ./run.sh /run.sh
ADD ./gitlab-runner-init.sh /etc/init.d/gitlab-runner
ADD ./config.toml /etc/gitlab-runner/config.toml

# Gradle
WORKDIR /opt
RUN wget http://services.gradle.org/distributions/gradle-3.5.1-bin.zip && \
    unzip -q gradle-3.5.1-bin.zip && \
    ln -s gradle-3.5.1 gradle && rm gradle-3.5.1-bin.zip
ENV GRADLE_HOME=/opt/gradle
ENV PATH=$PATH:$GRADLE_HOME/bin
RUN chmod 777 $GRADLE_HOME/bin/gradle

# GitLab CI Runner
RUN apk update && \
    apk add libstdc++ && \
    wget -O /usr/local/bin/gitlab-ci-multi-runner http://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-ci-multi-runner-linux-amd64 && \
    chmod +x /usr/local/bin/gitlab-ci-multi-runner
# RUN ln -s /etc/init.d/gitlab-runner /etc/runlevels/default/gitlab-runner
# RUN ln -s /etc/init.d/gitlab-runner /etc/runlevels/shutdown/gitlab-runner
# RUN gitlab-ci-multi-runner install --user=root --working-directory=/data/services

CMD ["/bin/sh","/run.sh"]
