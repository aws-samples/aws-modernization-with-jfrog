---
title: "Generate an API Key"
chapter: false
weight: 322
pre: "<b>3.2.2 </b>"
---
{{% notice info %}}
The JFrog Platform offers a universal solution supporting all major package formats including Alpine, Maven, Gradle, Docker, Conda, Conan, Debian, Go, Helm, Vagrant, YUM, P2, Ivy, NuGet, PHP, NPM, RubyGems, PyPI, Bower, CocoaPods, GitLFS, Opkg, SBT and more. 
{{% /notice %}}

1. Go to your JFrog Platform instance at _https://[server name].jfrog.io_. Refer to your _JFrog Free Subscription Activation_ email if needed. Substitute your _server name_.
![Activation Email](/images/activation-email.png)
2. Login to your JFrog Platform instance with your credentials.
![Login](/images/login.png)
3. Once logged into your JFrog Platform instance, you will be presented with the landing page.
![Landing](/images/landing.png)
4. Go to your profile and select **Edit Profile**.
![Edit Profile](/images/edit-profile.png)
5. Enter your password and click **Unlock** to edit the profile.
6. In the **Authentication Settings** section, click the gear icon to generate an API key.
![Api Key](/images/api-key.png)
7. Copy the **API Key**.

{{% notice tip %}}
Remember your username and API Key. We will use it again with the JFrog CLI and to set up ECS to deploy our image.
{{% /notice %}}


