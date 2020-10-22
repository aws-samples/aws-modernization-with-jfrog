---
title: "Execute the Initialization Pipeline"
chapter: false
weight: 60
pre: "<b>6. </b>"
---
The first pipeline that we will execute will initialize our environment. This pipeline will create users, groups, permissions, repositories, Xray policies and watches, Xray indexes and access federation. This prepares our JFrog Platform instance to run our NPM build pipeline.

{{% notice info %}}
This pipeline initializes the JFrog Platform for the next build pipelines by creating the necessary users, repositories, permissions and Xray configuration. It does this by using the [JFrog Platform REST APIs](https://www.jfrog.com/confluence/display/JFROG/REST+API). This is another way that you can manage and monitor the JFrog Platform. 
{{% /notice %}}

1. Go to **Pipelines** ► **My Pipelines**.
![My Pipelines](/images/pipelines-list.png)
2. Click on the **init_jfrog** pipeline in the **Pipelines List**.
3. Click on the first step and further click on the trigger step icon to execute this pipeline. A run will appear, and it will take a few moments for JFrog Pipelines to allocate resources to execute the pipeline.
![Trigger Init Pipeline](/images/trigger-init-jfrog.png)
4. It will take a few minutes for the pipeline to execute. While you are waiting, check out the following infographic on _Accelerating DevOps in the Cloud_.
{{< figure src="/images/devops-in-the-cloud.jpg" target="devops-in-the-cloud" title="DevOps in the Cloud" link="https://jfrog.com/infographic/accelerate-devops-in-the-cloud/">}}
5. If the execution results in an error, click on the run to view the logs. Make any changes to the pipeline or integrations to correct any issues and then execute again.
![Run Error](/images/run-error.png)
6. The run will show a _Success_ status when it completes without errors.
![Run Success](/images/run-success.png)

We are now ready to build our first artifacts for our application.

