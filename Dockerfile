FROM openjdk:8-jdk

VOLUME /data/services

ADD ./run.sh /run.sh

# Gradle
WORKDIR /opt
RUN wget https://services.gradle.org/distributions/gradle-3.3-bin.zip
RUN unzip gradle-3.3-bin.zip
RUN ln -s gradle-3.3 gradle && rm gradle-3.3-bin.zip
ENV GRADLE_HOME=/opt/gradle
ENV PATH=$PATH:$GRADLE_HOME/bin
RUN chmod 777 $GRADLE_HOME/bin/gradle

# GitLab CI Runner
RUN wget -O /usr/local/bin/gitlab-ci-multi-runner https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-ci-multi-runner-linux-amd64
RUN chmod +x /usr/local/bin/gitlab-ci-multi-runner
RUN gitlab-ci-multi-runner install --user=root --working-directory=/data/services

CMD ["/bin/bash","/run.sh"]
