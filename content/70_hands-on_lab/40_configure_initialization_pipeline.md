---
title: "Configure the Initialization Pipeline"
chapter: false
weight: 40
pre: "<b>4. </b>"
---

Next, we will update the lab pipelines to add your new GitHub and Artifactory integrations. In previous steps, you [forked and cloned the lab repository.](/70_hands-on_lab/10_fork_lab_repo.html) We will modify the initialization pipeline in your forked repository to add these integrations.

1. In your local git directory, open ```aws-modernization-with-jfrog/jfrog_pipelines/init-jfrog.yml``` in your Cloud9 editor.
2. Update the resources section of the file to use your new forked repository. Change the _path_ and substitute your username.

```
resources:  
  - name: gitRepo_code  
    type: GitRepo  
    configuration:  
      path: [your_Github_username]/aws-modernization-with-jfrog  <<<--- CHANGE HERE
      gitProvider: GitHub  
```

3. Save your changes.

4. In your terminal, git add, commit and push your changes.

```shell script
git add . 
git commit -m 'Updated repository path.'
git push
```

5. Go to https://github.com/[username]/aws-modernization-with-jfrog/blob/master/jfrog_pipelines/init-jfrog.yml and verify that your changes were made and pushed to your GitHub repository. Substitute your _username_.

We are now ready to add and execute your pipelines with JFrog Pipelines.