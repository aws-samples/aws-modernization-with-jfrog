---
title: "Set Up Xray Security"
chapter: false
weight: 28
pre: "<b>2.8 </b>"
---

1. In your JFrog Platform instance, go to **Administration** > **Xray** > **Watches & Policies**.

    ![Watches & Policies](/images/watches-policies.png)

2. Click **Create a Policy**.

3. Call the security policy, _High-Severity_.

    ![Policy Name](/images/policy-name.png)

4. Click on **New Rule**.

5. Name the rule _High-Severity_ and select **High** for the **Minimal Severity**. Click **Save**.

    ![Xray Rule](/images/xray-rule.png)

6. Click **Create** to create this new security policy.

7. Click on the **Watches** tab under **Watches & Policies**.

    ![Setup Watch](/images/setup-watch.png)

8. Click on **Set up a Watch**.

9. Name the new watch _Docker-Scanning_.

10. Click **Add Repositories**.

11. Move the repositories **workshop-docker-local** and **workshop-docker-prod-local** to the **Included Repositories**.

    ![Scanned Repositories](/images/scanned-repositories.png)

12. Click **Save**.

13. Click **Manage Policies**.

14. Move the **High-Severity** policy to the **Included Policy**.

    ![Selected Policy](/images/selected-policy.png)

15. Click **Save**.

16. Click **Create** to create the new watch. This watch will scan the **workshop-docker-local** and **workshop-docker-prod-local** Docker repositories for new images and check for high severity security vulnerabilities.

    ![Created Watch](/images/created-watch.png)

{{% notice info %}}
JFrog Xray scans your artifacts, builds and release bundles for OSS components, and detects security vulnerabilities and licenses in your software components.
Policies and Watches allow you to enforce your organization governance standards. Setup up your Policies and Watches to reflect standard governance behaviour specifications for your organization across your software components.
{{% /notice %}}

