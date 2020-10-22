---
title: "Configure the Artifactory Integration"
chapter: false
weight: 30
pre: "<b>3. </b>"
---
Similar to the GitHub Integration, in the following steps you will configure an Artifactory Integration that allows JFrog Pipelines to also access your Artifactory repositories in order to publish your artifacts and build info. You will do this by creating an API key.

{{% notice info %}}
Artifactory offers a universal solution supporting all major package formats including Alpine, Maven, Gradle, Docker, Conda, Conan, Debian, Go, Helm, Vagrant, YUM, P2, Ivy, NuGet, PHP, NPM, RubyGems, PyPI, Bower, CocoaPods, GitLFS, Opkg, SBT and more. 
{{% /notice %}}

1. In your JFrog Platform instance, go your profile and select **Edit Profile**.
2. Enter your password and click **Unlock** to edit the profile.
3. In the **Authentication Settings** section, click the gear icon to generate an API key.
![ApiKey](/images/api-key.png)
4. Copy the **API Key**.
5. Go back to **Integrations**, select **Pipelines** ► **Integrations**.
![Pipelines](/images/pipeline-integrations.png)
6. Click on **Add an Integration**.
7. Give this integration the name ```Artifactory```.
8. For the **Integration Type**, choose **Artifactory**.
9. Enter your JFrog Platform instance URL ```https://[server name].jfrog.io/artifactory``` for the **url**. Substitute your _server name_.
10. Enter your username for the **User**.
11. Paste your Artifactory API Key into the **API Key** field.
![Artifactory Integration](/images/add-artifactory-integration.png)
10. Click **Create**.

{{% notice tip %}}
Remember this Artifactory username and API Key. We will use it again on the next step to set up ECS to deploy our image.
{{% /notice %}}

You have created an Artifactory Integration that allows JFrog Pipelines to access your Artifactory repositories. At this point, you should see the Artifactory and the GitHub Integrations in the Integrations list.

![Integrations List](/images/integrations-list.png)


