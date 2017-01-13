# GitLab CI Runner with Java 8 and Gradle

This repository contains just the docker configuration for a GitLab CI Runner armored with Java 8 based on OpenJDK and Gradle.

`provocon/gitlabci-gradle-java`

The GitLab CI runner has to be configured via the environment variables:

- `CI_NAME` name of the runner
- `CI_URL` URL of the GitLab CI instance
- `CI_TOKEN` token to identify the project
- `CI_SSH` ssh key to identify the runner (base64 encoded)
- `CI_SSH_PUB` public ssh key to identify the runner (base64 encoded)

The container exposes ports 80, 8080, 443, 8443, 10080, and 1111.

## Usage

Use it in your .gitlab-ci.yml with e.g.

```
image: provocon/gitlabci-gradle-java

stages:
  - modules

build_modules:
  stage: modules
  script: 
  - gradle build
```

## Notes
 
Inspired by https://github.com/dominikhastrich/docker-java-gitlab-cd
 