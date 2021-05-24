---
title: "Set up our JFrog Pipelines Integrations"
chapter: false
weight: 42
pre: "<b>4.2 </b>"
---

Our CI/CD pipeline requires access to GitHub to pull our code, access to JFrog Artifactory to deploy our Docker image and access to AWS to deploy to ECS. We will set up JFrog Pipelines integrations to enable these.

![Pipelines Integration](/images/pipeline-integrations-diagram.png)

{{% notice info %}}
An Integration connects Pipelines to an external service/tool. Each integration type defines the endpoint, credentials and any other configuration detail required for Pipelines to exchange information with the service. All credential information is encrypted and held in secure storage, in conformance with best security practices.
{{% /notice %}}

{{% notice warning %}}
You may have already created these integrations in previous steps. If so, you can reuse them and do not need to recreate them. JFrog Pipelines allows you to share integrations and resources across pipelines.
{{% /notice %}}

1. In your JFrog Platform instance, go to **Administration** > **Pipelines** > **Integrations**.

2. Click **Add an Integration**.

3. For the **Name**, enter _artifactory\_integration_.

4. For **Integration Type**, select **Artifactory**.

5. Click **Get API Key** to generate an API key.

6. Click **Test connection** to validate.

7. Click **Create** to create the integration.

![Artifactory Integration](/images/artifactory-integration.png)

11. Click **Add an Integration** again.

12. For the **Name**, enter _github\_integration_.

13. For **Integration Type**, select **GitHub**.

14. Copy and paste your GitHub personal access token.

   Ensure it has these minimum GitHub permissions:

    - repo (all)
    - admin:repo_hook (read, write)
    - admin:public_key (read, write)

15. Click **Test connection** to validate.

16. Click **Create** to create the integration.
![GitHub Integration](/images/github-integration.png)

17. In your Cloud9 terminal, execute the following commands to create a AWS user and access key ID and secret access key.

```
aws iam create-user --user-name workshopuser
aws iam create-access-key --user-name workshopuser
```

18. Copy the output of these commands.

![AWS Access Key](/images/aws-access-key.png)

19. Go back to your JFrog Platform instance and go to **Administration** > **Pipelines** > **Integrations**.

20. Click **Add an Integration** again.

21. For the **Name**, enter _aws\_integration_.

22. For **Integration Type**, select **AWS**.

23. For the **Access Key Id** and the **Secret Access Key**, enter the values from above.

24. Click **Create** to create the integration.

![AWS Integration](/images/aws-integration.png)

Congratulations! We have created the integrations that are required for our CI/CD pipeline.
