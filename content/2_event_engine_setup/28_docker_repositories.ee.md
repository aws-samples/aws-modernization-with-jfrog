---
title: "Set Up Docker Repositories"
chapter: false
weight: 27
pre: "<b>2.7 </b>"
---
   
1. In your JFrog Platform instance at the top right, enable the drop down menu and select **Quick Setup**.

    ![Quick Setup](/images/quick-setup.png)

2. On the **Create Repositories** dialog, choose **Docker** and click **Next**.

    ![Create Repositories](/images/create-repositories.png)

3. Next, enter _workshop_ for the **Repositories Prefix**. 
   
4. Click **Create**. This will create the following docker repositories:

    - workshop-docker-local
    - workshop-docker-remote
    - workshop-docker

    ![Repositories Prefix](/images/repositories-prefix.png)

    - **Local repositories** are physical, locally-managed repositories into which you can deploy artifacts. These are repositories that are local to the JFrog Artifactory instance.
    - A **remote repository** serves as a caching proxy for a repository managed at a remote URL (which may itself be another Artifactory remote repository). 
    - A **virtual repository** (or "repository group") aggregates several repositories with the same package type under a common URL. A virtual repository can aggregate local and remote repositories.

5. Next, let's create another docker repository to represent production images. Click the **Add Repositories** button and select **Local Repository**.

    ![Add Repositories](/images/add-repositories.png)

6. Select **Docker** for the Package Type.

7. Name this docker repository _workshop-docker-prod-local_. Click **Save & Finish**.

    ![Add Repositories](/images/new-local-repository.png)

8. Click on the **Virtual** tab under **Repositories**.

    ![Virtual Repository](/images/virtual-repository.png)

9. Click on the **workshop-docker** virtual repository.

10. Move the new **workshop-docker-prod-local** repository under **Selected Repositories**.

    ![Move Repository](/images/move-repository.png)

11. Under Default Deployment Repository, select **workshop-docker-prod-local** as the default deployment repository. This means that image deployments from virtual repository workshop-docker will actually deploy from the local repository _workshop-docker-prod-local_.

    ![Default Deployment Repository](/images/default-deployment-repository.png)

12. Click **Save & Finish**.

13. Under the **Local** tab under **Repositories**, select the **workshop-docker-local** repository.

    ![Local Repositories](/images/local-repositories.png)

14. Scroll down and check **Enable Indexing in Xray**. This tells Xray to automatically scan this repository.

15. Click **Save & Finish**.


Congratulations! You have set up your Docker repositories. Now let's configure our security policies for Xray.


