# Jenkins CI/CD Pipeline

# Project Description
This repository demonstrates a CI/CD pipeline using Jenkins.  
It shows how to automate building, testing and deploying an application whenever code is pushed to GitHub.

---

# Repository Structure
 jenkins-pipeline-app/
      
    │── Jenkinsfile - Defines the pipeline stages
    │── README.md - This file
    │── Dockerfile - For building Docker images
    |── server.js - the main file that starts a Node.js application and handles incoming requests.
    |── package.json - A file that manages a Node.js project's dependencies and scripts
    |── demo.txt - A file that triggers a build (can be randomly named/random content to trigger)

# Prerequisites
- Jenkins installed and running (JDK 17+)
- GitHub repository
- ngrok (for exposing local Jenkins server to GitHub)
- Git installed on Jenkins server

---

# Install Required Jenkins Plugins
   1. Go to Manage Jenkins → Manage Plugins → Available
   2. Search for:
      - GitHub plugin
      - Pipeline
   3. Click Install without restart

---

# Create a Jenkins Pipeline Job
   1. Go to Jenkins dashboard - New Item 
   2. Enter job name: `myapp-pipeline`  
   3. Select Pipeline
   4. Under Pipeline section:
     - Definition: Pipeline script from SCM  
     - SCM: Git  
     - Repository URL: `https://github.com/basith46/jenkins-pipeline-app.git`  
     - Branch: `main`  
     - Script Path: `Jenkinsfile`  
   5. Under Build Triggers:
     - Check GitHub hook trigger for GITScm polling
   6. Click Save

---

# Expose Jenkins to GitHub
If Jenkins is running locally:

1. Start ngrok to expose Jenkins:
   ```bash
   ngrok http 8080

Copy the HTTPS URL from ngrok (https://unlicentiated-urijah-decayable.ngrok-free.dev)

# Configure GitHub Webhook
   1. Go to GitHub → Settings → Webhooks → Add webhook
   2. Set the following:

          * Payload URL: https://unlicentiated-urijah-decayable.ngrok-free.dev/github-webhook/
          * Content type: application/json
          * Events: Push events only
   4. Save the webhook
   5. Make sure ngrok is running while testing; otherwise GitHub cannot reach Jenkins.

# Trigger a Build
   1.Make a change in your repo:
     
     * echo "Demo for jenkins trigger" >> demo.txt
     * git add demo.txt
     * git commit -m "Trigger Jenkins build"
     * git push origin main
   2. Jenkins will automatically start the build
   3. Verify in Jenkins → myapp-pipeline → Build History

# Notes & Tips
    * Keep ngrok running during demos; the URL changes if restarted.
    * Ensure Jenkinsfile is at the root of the repo.
    * Use HTTPS for webhook URLs.
    * For production, consider using a public server or domain instead of ngrok.

# Demo Flow
  * Push code to GitHub
  * GitHub webhook sends a POST to Jenkins
  * Jenkins automatically starts the pipeline
  * Monitor Build History and Console Output to see stages executing

# References
    * Jenkins Documentation: https://www.jenkins.io/doc
    * GitHub Webhooks: https://docs.github.com/en/developers/webhooks-and-events/webhooks
    * ngrok: https://ngrok.com/docs
