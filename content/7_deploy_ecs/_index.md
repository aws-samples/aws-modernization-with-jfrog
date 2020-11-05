---
title: "Deploy on Amazon ECS"
chapter: false
weight: 7
pre: "<b>7 </b>"
---

We are now ready to deploy your image with Amazon ECS. If not yet created, Amazon ECS can create a new VPC and ECS cluster as well as the other components that are required to serve your application. Amazon ECS will then authenticate, pull the image from Artifactory and deploy the container to the ECS cluster.

![ECS Architecture](/images/ecs-architecture.svg)
