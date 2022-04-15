---
title: "Introduction"
chapter: false
weight: 1
pre: "<b>1 </b>"
---

In this workshop, we will demonstrate DevOps in the cloud with AWS and JFrog and observability with Pagerduty. We will build and deploy a containerized NPM application. Using the JFrog Platform, we will execute a docker build and push, security scan the image, promotion and publish it to a repository and at the same time we will create services in Pagerduty and create webhooks in JFrog platform for artifactory, pipelines and xray to capture all those incidents and vulnerabilities . We will then deploy the image and serve the application with Amazon EKS. To automate this whole process of build, scan and deploy we will use JFrog Pipelines.

![Detail Diagram](/images/aws-jfrog-pd-cicd.png)

![NPM Application](/images/aws-jfrog-pd.png)



