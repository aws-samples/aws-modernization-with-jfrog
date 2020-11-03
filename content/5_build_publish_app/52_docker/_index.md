---
title: "Build and Push the Docker Image"
chapter: false
weight: 52
pre: "<b>5.2 </b>"
---

We will now build a Docker image with our NPM package and publish the image to our JFrog Artifactory repository.

![JFrog CLI Docker](/images/jfrog-cli-docker.svg)

1. Return to your Cloud9 terminal. 

2. Let's create a Docker image for our NPM application. Substitute your _server name_ in the following command.

``
docker build -t <server name>.jfrog.io/docker-demo/npm-app:latest .
``

This command should result in a successful Docker image build.
![Docker Build](/images/docker-build.png)

3. Now use the JFrog CLI to push the docker image. Substitute your _server name_ in the following command.

``
jfrog rt docker-push <server name>.jfrog.io/docker-demo/npm-app:latest docker-demo --build-name=npm_build --build-number=1
``

4. Now trigger a Xray scan of the build.

``
jfrog rt build-scan npm_build 1
``

This command should result in successful scanning.
![Xray Scan](/images/xray-scan.png)

5. If our build passes the Xray scan, we can promote it with the following command. This promotes from the _dev_ repository to the _prod_ repository. Substitute your _server name_ in the following command.

``
jfrog rt docker-promote npm-app docker-demo-dev-local docker-demo-prod-local
``

6. In your JFrog Platform instance, go to **Artifactory** ► **Artifacts** to see this in the docker repositories.

![Promote](/images/promote.png)
