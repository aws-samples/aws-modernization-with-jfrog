---
title: "View Events in PagerDuty"
chapter: false
weight: 58
pre: "<b>5.8 </b>"
---

1. Go to your Pagerduty instance, navigate to **Services** > **Service Directory** and search and select _Artifactory and Pipelines evnts_. You should be able to see all the change events and notifications from Pipelines and Artifactory.
    ![Pagerduty Events](/images/pd-art-pipe-events.png)

2. Now click on any pipeline event. This will give you information about that Jfrog pipeline event and if you click on **View in Build Pipeline** , it will take you to that particular pipeline in JFrog instance.
    ![Pagerduty Pipeline Events](/images/pd-pipe-event.png)

3. Now select any artifactory event. This will give you information about that event like docker image name, which repo it was deployed etc.
    ![Pagerduty Art Events](/images/pd-art-event.png)

4. On the service page you can assign that to any team, connected to any communication channel like slack or view audit trail and many more.
    ![Pagerduty More Options](/images/pd-more-options.png)

5. Now ho back to **Service Directory** , search and select _Xray Vulnerabilities_. You should be able to see lots of **Incidents** telling about vulnerabilities. You can achnowledge, assign or take any action based on priority.
    ![Pagerduty Xray](/images/pd-xray.png)

6. Select any of the Incident and you can see more details about it like severity, impacted artifacts, CVE etc.
    ![Pagerduty Xray Incident](/images/pd-xray-vuln.png)

