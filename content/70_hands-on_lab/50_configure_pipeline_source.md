---
title: "Configure the Pipeline Source"
chapter: false
weight: 50
pre: "<b>5. </b>"
---

In these next steps, we will add the build pipelines as a JFrog Pipelines source. This will allow JFrog Pipelines to execute these pipelines automatically whenever there is a commit or manually as needed.

{{% notice info %}}
A Pipeline Source represents a source control repository (such as GitHub or BitBucket) where Pipelines definition files can be found. A pipeline source connects to the repository through an integration.
{{% /notice %}}

1. In your JFrog Platform instance, go to **Pipelines** ► **Pipeline Sources**.
![Pipeline Sources](/images/pipeline-sources.png)
2. Click on **Add Pipeline Source**.
3. Choose **Single Branch**. This is for repositories that only have one branch like _master_.
4. For the **Integration** choose the GitHub Integration that you created previously named _GitHub_.
5. For the **Repository Full Name**, specify your aws-modernization-with-jfrog repository name in the form ```[username]/aws-modernization-with-jfrog```. Substitute your _username_.
6. Leave the **Branch** as _master_.
7. For the **Pipeline Config Filter**, specify ```jfrog_pipelines/.*yml```
8. Click **Create**.
![PipelineSource](/images/add-pipeline-source.png)

It will take a few moments for JFrog Pipelines to sync the pipelines from your new Pipelines Source. During this time, JFrog Pipelines will load and process the pipelines for syntax, resources and dependencies. When complete, you should see a _Success_ status. 
![Pipelines Source Success](/images/pipeline-source-success.png)
9. Click on **Logs** on the right to view more details on the sync process.
![Pipelines Logs](/images/pipeline-log.png)
10. Go back to **Pipelines** ► **My Pipelines**, and you will see your added pipelines.
![My Pipelines](/images/pipelines-list.png)

With your pipelines added, we are now ready to execute the pipelines to initialize our environment and build our artifacts!

