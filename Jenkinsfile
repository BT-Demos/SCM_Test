Skip to:
Top Bar
Main Content
Sidebar


Search

Create

Ask Rovo

2




Starred

Starred

Recent

Recent

Recent

Spaces
Support Engineering Collaboration
Support Engineering ...

SECO-5656


registerBuildArtifactMetadata and registerDeployedArtifactMetadata throw an error when used by a build that is triggered by an upstream build




Key details
Type of Help Requested


Confirm new bug
Description

Case Summary
Environment Information
Product: CI Modern

Version: 2.568.1.37443

CloudBees Unify Connection Plugin :: Common 1.1934

CloudBees Unify Integration Plugin :: Controllers 1.1934

(I tested on an HA controller, but I don’t think that has anything to do with the error)

Symptom
The steps registerBuildArtifactMetadata and registerDeployedArtifactMetadata throw an error when used by a build that is triggered by an upstream build.



ERROR: Failed to register deployed artifact metadata for the run 7 in item ddewhurst/unify_dora_mb_test/downstream-branch. CloudBees Unify response PostBuildEventResponse{success=false, errorMessage='unable to retrieve run details for this workflow. check that the component has been created for this repository', errorCode=5, httpStatus=404, errorDetails=[], eventOutput=null}


ERROR: Failed to register build artifact metadata for the run 7 in item ddewhurst/unify_dora_mb_test/upstream-branch. CloudBees Unify response PostBuildEventResponse{success=false, errorMessage='unable to retrieve run details for this workflow. check that the component has been created for this repository', errorCode=5, httpStatus=404, errorDetails=[], eventOutput=null}
Evidence/Detail
I have attached the two Jenkinsfile that I used to reproduce this. I put each into their own branch of the same repo. Initially these two were in the same Jenkinsfile so I know these steps worked in that setup. Then I split them into upstream/downstream when trying to troubleshoot a customer issue and ran into this problem.

Reproduction Steps
Connect Unify to CI:

https://docs.cloudbees.com/docs/cloudbees-unify/latest/continuous-integration/how-to-guides/connect-ci-jenkins-controllers

Put the two Jenkinsfile into separate branches of a repo and create a Unify Component for the repo. Make sure to edit the Jenkinsfile to be compatible with your setup (environment name, build step path).

https://docs.cloudbees.com/docs/cloudbees-unify/latest/platform-administration/how-to-guides/manage-components

Create an Environment in Unify

https://docs.cloudbees.com/docs/cloudbees-unify/latest/platform-administration/how-to-guides/manage-environments

Create a multibranch job in CI for your repo

Run the upstream build. See the error thrown in the downstream build.

Combine them into one Jenkinsfile if you want to confirm the logic works otherwise. Or manually run the downstream job while providing the artifactID from the upstream.

Hypothesis
It seems the step fails to properly gather builds details when it is triggered by an upstream build.

What help is needed from Backend DSE and/or Engineering
Please confirm this bug.

As a secondary request, please add some sort of output message for the registerDeployedArtifactMetadata. Currently, it has no output so when it is successful, you don't have any confirmation.

Please see Zendesk Support tab for further comments and attachments.

Zendesk Ticket IDs


276931

Attachments
2


Jenkinsfile_downstream.txt
Jenkinsfile_downstream.txt
01 Aug 2026, 06:37 am


Jenkinsfile_upstream.txt
Jenkinsfile_upstream.txt
01 Aug 2026, 06:37 am



Linked work items

is addressed by
Work type: Bug
CBP-55142

Code Review

Priority: Medium

Agents
Uses AI. Verify results.

Start work

Activity

All

Comments

History

Work log

Smart Checklist History

Zendesk Support

Approvals



Add a comment…

Suggest a reply...

Status update...

Thanks...
Pro tip: press 
M
 to comment

Guruprasad Bhat

2 days ago



Guruprasad Bhat

2 days ago



Mike Cirioli

4 days ago



2



Defect

Agents
New Defect


Improve Support
Details
Assignee



Sriman Padmanaban
Reporter



Dylan Dewhurst
Engineering Squad



CloudBees Cloud Native Platform (SaaS platform)
Customer name


Restoration Hardware
Zendesk Ticket Count



1
Severity



SEV-3 (Medium)
Priority



Medium
SECO_Subsystem



Add options
Labels


bwe-seco-no-eng
jira_escalated
jira_seg_unknown
SLO breached count



None
SLO respected count



1
Eng Answered Date



None
Eng Informed Date



1 Aug 2026
Due date


5 Aug 2026
Story Points



1
Original estimate


0m
Time tracking


2h logged
Feedback
Open Feedback
Development
More fields
Parent, Components, Sprint, Fix versions
Automation
Rule executions
Invision for Jira

Open Invision for Jira
PagerDuty

PagerDuty Incident
Sentry

Linked Issues
Zendesk Support

Linked Tickets
1
Agile Poker

Agile Poker
Connected items

Connected items
Created 4 days ago
Updated 18 hours ago
Resolved 18 hours ago



Jenkinsfile_upstream.txt
text · 1 KB

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
                sh 'echo "This is my archive" > archive.txt'
                archiveArtifacts artifacts: 'archive.txt', followSymlinks: false
            }
        }
        stage('Register build artifact') {
            steps {
                script {
                    env.ARTIFACT_ID = registerBuildArtifactMetadata(
                        name: "my-artifact",
                        version: "1.0.0",
                        url: "https://test.com/dse-team-amer/archive.txt"
                    )
                }
            }
        }
        stage('Run Deploy artifact downstream') {
            steps {
                build job: 'BT-Demos/SCM_Test/test2', 
                    parameters: [
                        string(name: 'DEPLOY_ARTIFACT_ID', value: env.ARTIFACT_ID)
                    ]
            }
        }
    }
}

