---
title: "JFrog Platform with Docker Compose & ECS"
chapter: true
draft: false
weight: 3
pre: "<b>3 </b>"
---

# JFrog Platform with Docker Compose & ECS

In this section, we will set up our CI/CD pipeline with JFrog Pipelines. Our pipeline, will take our application and build a docker image. Push it to a Docker repository. Scan it for security vulnerabilities. Then it will promote it. Finally, it will deploy it to our AWS ECS cluster using Docker Compose. You can learn more about how Docker Compose can be used to create and deploy to Amazon ECS [here](https://docs.docker.com/cloud/ecs-integration/). 

![Workshop Architecture](/images/workshop-architecture-ecs.png)

We will:

- Set up the workshop code.
- Set up our JFrog Pipelines integrations to connect to GitHub, AWS and our Artifactory repositories.
- Add our CI/CD pipeline to JFrog Pipelines. Then build and deploy our app.
- Automatically create a new ECS cluster with Docker Compose.

{{% notice info %}}
In this workshop, we use Docker, but the JFrog Platform is a universal solution supporting all major package formats including Alpine, Maven, Gradle, Docker, Conda, Conan, Debian, Go, Helm, Vagrant, YUM, P2, Ivy, NuGet, PHP, NPM, RubyGems, PyPI, Bower, CocoaPods, GitLFS, Opkg, SBT and more.
{{% /notice %}}
