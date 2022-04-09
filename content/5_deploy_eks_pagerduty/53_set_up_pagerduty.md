---
title: "Set up PagerDuty"
chapter: false
weight: 53
pre: "<b>5.3 </b>"
---

Next we will set up your PagerDuty Developer Platform. If you do not yet have a developer platform, you can sign up and get a free developer platform instance [here](https://developer.pagerduty.com/sign-up/).

{{% notice info %}}
PagerDuty provides many ways for developers to integrate with their platform. You can learn more through their [developer documentation](https://developer.pagerduty.com/docs/get-started/getting-started/).
{{% /notice %}}

1. In your PagerDuty, go to **Services** > **Service Directory**.
{{% notice info %}}
A service may represent an application, component, or team you wish to open incidents against. Services contain integrations, as well as determine the routing and incident settings for events triggered by integrations associated with the service.
{{% /notice %}}
2. We will create two services: (1) Xray Vulnerabilities and (2) JFrog Pipelines Events. Click **+ New Service **.
3. Name the service _Xray Vulnerabilities_ and click **Next**.
   ![New PD Service](/images/newpdservice.png)
4. Choose **Generate an Escalation Policy** and click **Next**.
   ![New PD Escalation](/images/newpdescalation.png)
5. Choose **Intelligent** for the **Alert Grouping** and click **Next**.
   ![New PD Alert](/images/pdalertgrouping.png)
6. For **Integrations**, search for _JFrog Xray Notifications_ and click **Create Service**.
   ![New PD Alert](/images/pd-jfrog-int.png)
7. Copy the **Integration URL** for later.
   ![New PD Xray Key](/images/pd-xray-int.png)
8. Let's now create a service for JFrog Pipelines and Artifactory events. Click **+ New Service **.
9. Name the service _Artifactory and Pipelines Events_ and click **Next**.
10. Choose **Generate an Escalation Policy** and click **Next**.
11. Choose **Intelligent** for the **Alert Grouping** and click **Next**.
12. For **Integrations**, search and select _JFrog Pipelines Changes_ and _JFrog Artifactory Notifications_ click **Create Service**.
   ![New PD Alert](/images/pdpipelines.png)
13. Copy the **Integration Key** for pipelines and **Integration URL** for artifactory to use later.
   ![New PD Pipeline Key](/images/pd-art-pipe.png)
    
Congratulations! You have set up PagerDuty with the JFrog Xray and Pipelines integrations.
