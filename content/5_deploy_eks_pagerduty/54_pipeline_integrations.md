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

15. Copy the output of these commands and save it somewhere to put in Jfrog Platform.
   ![AWS Access Key](/images/aws-access-key.png)

16. Now you will also have to update the configmap with the above user created in order to have access to EKS clusters in JFrog Platform. In Cloud9 terminal execute the following command to edit configmap.

```
kubectl edit -n kube-system configmap/aws-auth
```
17. Add the **MapUsers** section as shown in highlighted red box
    ```
    mapusers: |
      - userarn: arn:aws:iam::<id>:user/workshopuser
        username: workshopuser
        groups: 
          - system:masters
    ```
    
    ![AWS ConfigMap](/images/aws-edit-configmap.png)

18. Go back to your JFrog Platform instance and go to **Administration** > **Pipelines** > **Integrations**.

19. Click **Add an Integration** again.

20. For the **Name**, enter _aws\_integration_.

21. For **Integration Type**, select **AWS**.

22. For the **Access Key Id** and the **Secret Access Key**, enter the values from above.

23. Click **Create** to create the integration.
   ![AWS Integration](/images/aws-integration.png)
24. Click **Add an Integration** again.
25. For the **Name**, enter _eks\_integration_.
26. For **Integration Type**, select **Kubernetes**.
27. Paste in the Kubeconfig output from the steps where you created your EKS cluster.
28. Click **Create** to create the integration.
   ![EKS Integration](/images/eks-integration.png)
29. Click **Add an Integration** again.
30. For the **Name**, enter _pagerduty\_integration_.
31. For **Integration Type**, select **PagerDuty Events**.
32. Enter the PagerDuty Pipelines Integration Key created in the prior steps for **Service Integration/routing key**.
    ![PagerDuty Integration](/images/addpagerdutyintegration.png)
33. Click **Create**.
34. Go to **Administration** > **Xray** > **Settings**.
35. Click on **Webhooks** in the **General** tile.
36. Create a **New Webhook**.
37. Enter _Xray PagerDuty_ for the **Webhook Name**
38. Enter the PagerDuty Xray Integration URL for the **URL**.  _ex: https://events.pagerduty.com/integration/< integration id >/enqueue_
39. Click **Create**.
    ![PagerDuty Xray Webhook](/images/pdxraywebhook.png)
40. Go to **Administration** > **Xray** > **Watches & Policies**.
41. Click on the **High-Severity** policy that you created earlier.
42. Then click on the edit icon for the **High-Severity** rule that you created earlier.
    ![PagerDuty Edit Xray Rule](/images/pdeditxrayrule.png)
43. Scroll down and enable **Trigger Webhook** and select **Xray Pagerduty**, the webhook that you created in the previous steps.
44. Click **Save** to save the rule.
    ![PagerDuty Xray Webhook](/images/pdxraywebhookrule.png)
45. Click **Save** to save the policy.
46. Similarly, now create a webhook for artifactory also. Go to **Administration** > **General** > **Webhooks** and click on **New Webhook**.
47. Enter _Artifactory Pagerduty Docker_ for the **Webhook Name**
48. Enter the PagerDuty Artifactory Integration URL for the **URL** and select **Docker** from the **Events** and check all docker events.
    ![PagerDuty Artifactory Docker Webhook](/images/pd-art-web.png)
49. Repeat steps **46-48** to create one more webhook _Artifactory Pagerduty Artifact_ for the **events** Artifacts.


    

Congratulations! We have created the integrations that are required for our CI/CD pipeline.
