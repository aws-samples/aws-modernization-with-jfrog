---
title: "Attach the IAM role to your Workspace"
chapter: false
weight: 24
pre: "<b>2.4 </b>"
---

1. Follow [this link to find your Cloud9 EC2 instance](https://console.aws.amazon.com/ec2/v2/home?#Instances:sort=desc:launchTime).
2. Select the instance by clicking the checkbox, then choose **Actions** ► **Security** ► **Modify IAM role**.
    ![c9instancerole](/images/c9instancerole.png)
3. Select your zone from top if that is not the one.
4. Choose **JFrog-Workshop-Admin** from the **IAM Role** drop down, and click **Save**.
    ![c9attachrole](/images/c9attachrole.png)
