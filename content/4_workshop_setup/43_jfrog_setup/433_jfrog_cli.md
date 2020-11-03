---
title: "Install and Configure the JFrog CLI"
chapter: false
weight: 433
pre: "<b>4.3.3 </b>"
---

{{% notice info %}}
JFrog CLI is a client that provides a simple interface that automates access to JFrog products simplifying your automation scripts and making them more readable and easier to maintain. JFrog CLI works with JFrog Artifactory, JFrog Mission Control, JFrog Bintray and JFrog Xray (through their respective REST APIs) making your scripts more efficient and reliable. You can use the JFrog CLI to assist in your builds, create artifacts, promote artifacts, trigger security scans and much more. It is powerful to that you can use in your CI/CD process and general automation. You can learn more [here](https://www.jfrog.com/confluence/display/CLI/JFrog+CLI). 
{{% /notice %}}

1. In your Cloud9 terminal, run the following shell commands to install the JFrog CLI.

```
echo "[jfrog-cli]" > jfrog-cli.repo;
echo "name=jfrog-cli" >> jfrog-cli.repo;
echo "baseurl=https://releases.jfrog.io/artifactory/jfrog-rpms" >> jfrog-cli.repo;
echo "enabled=1" >> jfrog-cli.repo; echo "gpgcheck=0" >> jfrog-cli.repo;
sudo mv jfrog-cli.repo /etc/yum.repos.d/;
sudo yum install -y jfrog-cli;
```

2. Execute the following to test the JFrog CLI and check the version.

```
jfrog --version
```

3. Set the following environment variables. Substitute our JFrog Platform credentials (username and API key).

```
export jfrog_user=<username/email>
```

```
export jfrog_apikey=<api key>
```

3. Next, we will configure JFrog CLI to use our JFrog Platform credentials (username and API key) that we generated previously. Execute the following command.

```
jfrog rt config --user <username/email> --apikey <api key>
```

4. When prompted, enter a unique server ID such as your JFrog Platform server name.
5. Enter the URL for the JFrog Artifactory server which has the _artifactory_ path.
6. Then accept the remaining default values.

![JFrog CLI Config API Key](/images/jfrog-cli-config-api.png)

7. Execute the following to list your Artifactory servers configured for the JFrog CLI.

```
jfrog rt config show
```

8. Execute the following command to set the Artifactory server in use for the next commands. Use the _Artifactory server ID_ that you entered above.

```
jfrog rt use <Artifactory server ID>
```

9. Execute the following command to check connectivity to the server. You should get an _OK_ response.

```
jfrog rt ping
```
