---
title: "Update our Pipeline"
chapter: false
weight: 55
pre: "<b>5.5 </b>"
---

We need to make an update to our CI/CD pipeline in order to use your JFrog Platform instance. The CI/CD pipeline is defined in [pipelines.yml](https://github.com/jfrogtraining/pagerduty-workshop/blob/master/pipelines.yml). This pipeline file is parameterized with a [values.yml](https://github.com/jfrogtraining/pagerduty-workshop/blob/master/values.yml) file. We need to update this file.

1. In your Cloud9 terminal, use the editor and view the pipelines.yml file. View and understand the steps. Note the parameterized values.
    ![Cloud9 Editor Pipelines](/images/editor-pipelines-pd.png)

2. The last step in the pipeline, _eks\_deploy_, deploys our application to the EKS cluster we created earlier. This is achieved with the K8s [deployment.yml](https://github.com/jfrogtraining/pagerduty-workshop/blob/master/workshop-app/deployment.yml) manifest. View this file in the editor.
    ![Cloud9 Editor Deployment](/images/editor-deploy-pd.png)

3. In the editor, select the values.yml file and updated the parameterized values to point to your JFrog Platform instance and your forked repo. Save the changes.

```
Artifactory:
  server: partnership.jfrog.io #change to your servername
  intName: artifactory_integration
  devRepo: workshop-docker-local
  prodRepo: workshop-docker-prod-local
PagerDuty:
  intName: pagerduty_integration
  pipelinesRoutingKey: xxxxxx #change to your pagerduty pipelines integration key
GitHub:
  path: jfrogtraining/pagerduty-workshop #change to your github username
  gitProvider: github_integration
AWS:
  intName: aws_integration
  eks: eks_integration
  region: us-west-2
app:
  dockerImageName: partnership.jfrog.io/workshop-docker/pagerduty-workshop-app #change to your servername
  dockerFileLocation: workshop-app
  buildName: pagerduty-workshop-app
```

4. In your Cloud9 terminal, commit these changes.

```
git add .
git commit -m 'Updated values.yml.'
```

5. Next, push these updates. When prompted for a username and password, use your GitHub username and personal access token/password.

    ```
    git push origin master
    ```
    
    We are now ready to add your CI/CD pipeline and execute!
