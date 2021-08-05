---
title: "Set up our JFrog Pipelines Integrations"
chapter: false
weight: 54
pre: "<b>5.4 </b>"
---

Our CI/CD pipeline requires access to GitHub to pull our code, access to JFrog Artifactory to deploy our Docker image and access to AWS to deploy to EKS. We will set up JFrog Pipelines integrations to enable these.

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

8. Click **Add an Integration** again.

9. For the **Name**, enter _github\_integration_.

10. For **Integration Type**, select **GitHub**.

11. Copy and paste your GitHub personal access token. Ensure it has these minimum GitHub permissions:

    - repo (all)
    - admin:repo_hook (read, write)
    - admin:public_key (read, write)

12. Click **Test connection** to validate.

13. Click **Create** to create the integration.
   ![GitHub Integration](/images/github-integration.png)

14. In your Cloud9 terminal, execute the following commands to create a AWS user and access key ID and secret access key.

```
aws iam create-user --user-name workshopuser
aws iam attach-user-policy --user-name workshopuser --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
aws iam create-access-key --user-name workshopuser
```

15. Copy the output of these commands.
   ![AWS Access Key](/images/aws-access-key.png)

16. Go back to your JFrog Platform instance and go to **Administration** > **Pipelines** > **Integrations**.

17. Click **Add an Integration** again.

18. For the **Name**, enter _aws\_integration_.

19. For **Integration Type**, select **AWS**.

20. For the **Access Key Id** and the **Secret Access Key**, enter the values from above.

21. Click **Create** to create the integration.
   ![AWS Integration](/images/aws-integration.png)
22. Click **Add an Integration** again.
23. For the **Name**, enter _eks\_integration_.
24. For **Integration Type**, select **Kubernetes**.
25. Paste in the Kubeconfig output from the steps where you created your EKS cluster.
26. Click **Create** to create the integration.
   ![EKS Integration](/images/eks-integration.png)
27. Click **Add an Integration** again.
28. For the **Name**, enter _pagerduty\_integration_.
29. For **Integration Type**, select **PagerDuty Events**.
30. Enter the PagerDuty Pipelines Integration Key created in the prior steps for **Service Integration/routing key**.
    ![PagerDuty Integration](/images/addpagerdutyintegration.png)
31. Click **Create**.
32. Go to **Administration** > **Xray** > **Settings**.
33. Click on **Webhooks** in the **General** tile.
34. Create a **New Webhook**.
35. Enter _Xray PagerDuty_ for the **Webhook Name**
36. Enter the PagerDuty Xray Integration URL for the **URL**.  _ex: https://events.pagerduty.com/integration/< integration id >/enqueue_
37. Click **Create**.
    ![PagerDuty Xray Webhook](/images/pdxraywebhook.png)
38. Go to **Administration** > **Xray** > **Watches & Policies**.
39. Click on the **High-Severity** policy that you created earlier.
40. Then click on the edit icon for the **High-Severity** rule that you created earlier.
    ![PagerDuty Edit Xray Rule](/images/pdeditxrayrule.png)
41. Scroll down and enable **Trigger Webhook** and select **Xray Pagerduty**, the webhook that you created in the previous steps.
42. Click **Save** to save the rule.
    ![PagerDuty Xray Webhook](/images/pdxraywebhookrule.png)
43. Click **Save** to save the policy.
    

Congratulations! We have created the integrations that are required for our CI/CD pipeline.
