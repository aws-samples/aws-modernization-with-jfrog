---
title: "Build, Publish and Deploy to EKS"
chapter: false
weight: 55
pre: "<b>5.6 </b>"
---

1. In your JFrog Platform instance, go to **Application** > **Pipelines** > **Pipeline Sources**.
    ![Pipeline Sources](/images/pipeline-sources.png)

2. Click **Add a pipeline source**.

3. Click **Add Pipeline Source** at the top right and select **From YAML**.
    ![Pipeline From YAML](/images/pipeline-from-yaml.png)

4. For **SCM Provider Integration**, select the **github_integration** that you created previously.

5. For **Repository Full Name**, select your forked **<username>/aws-eks-workshop**.

6. For **Branch**, select **master**.

7. Leave **Pipeline Config File Filter** as _pipelines.yml_.
    ![Create Pipeline Source](/images/create-pipeline-source-eks.png)

8. Click **Create Source**. JFrog Pipelines will process the CI/CD pipeline. The status should show **Not Synced** then **Syncing** and then **Success**.
    ![Success Pipeline Source](/images/success-pipeline-source-eks.png)

9. Go to **Application** > **Pipelines** > **My Pipelines**. Notice that your pipeline has a status of **Not Built**.
    ![My Pipelines](/images/my-pipelines.png)

10. Click on your pipeline, **eks_workshop_app_build**.
    ![Workshop Pipeline](/images/workshop-pipeline-eks.png)

11. Click on the _app\_docker\_build_ step and trigger the step to execute the pipeline. JFrog Pipelines will allocate build nodes and execute your pipeline.
    ![Trigger Pipeline](/images/trigger-pipeline.png)

12. It will take a few minutes to execute. Click on the _Run_ to monitor the status of each step.

13. Use the pulldown to select each step and view the logs.
    ![Pipeline Step Logs](/images/pipeline-step-logs-eks.png)

14. When the pipeline execution completes (approximately 5-10 minutes), view the log for the _eks\_deploy_ step.

15. While this pipeline is executing, go to the [EKS console](https://us-west-2.console.aws.amazon.com/eks/home?region=us-west-2#/clusters) to observe the new cluster.

16. Scroll down to get the _$url_ value. Enter the value into your browser to view the application!
    ![EKS Deploy URL](/images/eks-deploy-url.png)
