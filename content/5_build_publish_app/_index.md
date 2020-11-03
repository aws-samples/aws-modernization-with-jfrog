---
title: "Build and Publish the NPM App"
chapter: false
weight: 5
pre: "<b>5 </b>"
---

1. Change directory to _aws-modernization-with-jfrog/workshop_app_.
2. Configure the NPM repositories with the JFrog CLI. Substitute the _Artifactory server ID_ that you entered previously.
```
jfrog rt npmc --repo-resolve npm-demo --repo-deploy npm-demo --server-id-resolve <Artifactory server ID> --server-id-deploy <Artifactory server ID>
```

3. Perform an NPM install with the JFrog CLI command to verify NPM dependencies.

```
jfrog rt npm-install --build-name=npm_build --build-number=1
```

4. Perform an NPM publish to package and deploy to the _npm-demo_ repository.

```
jfrog rt npm-publish --build-name=npm_build --build-number=1
```

5. Next, let's create a Docker image for our NPM application. Substitute your _server name_ in the following command.

```
docker build -t <server name>.jfrog.io/docker-demo/npm-app:latest .
```

6. Now use the JFrog CLI to push the docker image. Substitute your _server name_ in the following command.

```
jfrog rt docker-push <server name>.jfrog.io/docker-demo/npm-app:latest docker-demo --build-name=npm_build --build-number=1
```
7. Now trigger a Xray scan of the build.

```
jfrog rt build-scan npm_build 1
```

8. If our build passes the Xray scan, we can promote it with the following command. Substitute your _server name_ in the following command.

```
jfrog rt build-promote <server name>.jfrog.io/docker-demo/npm-app:latest docker-demo docker-demo-prod-local 
```
