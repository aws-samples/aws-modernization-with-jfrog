---
title: "Update our Pipeline"
chapter: false
weight: 43
pre: "<b>4.3 </b>"
---

We need to make an update to our CI/CD pipeline in order to use your JFrog Platform instance. The CI/CD pipeline is defined in [pipelines.yml](https://github.com/jfrogtraining/aws-ecs-docker-compose-workshop/blob/master/pipelines.yml). This pipeline file is parameterized with a [values.yml](https://github.com/jfrogtraining/aws-ecs-docker-compose-workshop/blob/master/values.yml) file. We need to update this file.

1. In your Cloud9 terminal, use the editor and view the pipelines.yml file. View and understand the steps. Note the parameterized values.

![Cloud9 Editor Pipelines](/images/editor-pipelines-ecs.png)

2. The last step in the pipeline, _ecs\_deploy_, deploys our application to an ECS cluster using _docker compose_ with a special ECS context. This is achieved with the [deploy.sh](https://github.com/jfrogtraining/aws-ecs-docker-compose-workshop/blob/master/deploy.sh) script. View this file in the editor.

![Cloud9 Editor Deploy](/images/editor-deploy-ecs.png)

2. In the editor, select the values.yml file and updated the parameterized values to point to your JFrog Platform instance and your forked repo. Save the changes.

![Cloud9 Editor Values](/images/editor-values-ecs.png)

3. In your Cloud9 terminal, commit these changes.

```
git add .
git commit -m 'Updated values.yml.'
```

4. Next, push these updates. When prompted for a username and password, use your GitHub username and personal access token.

``
git push origin master
``

We are now ready to add your CI/CD pipeline and execute!
