# Readme
This is a minimal example of developing a web application locally to be deployed as a docker container on GCP cloud run.  
Example uses streamlit but the setup should be quite interchangeable with flask or node or whatever.  
Docker desktop must already be configured.    

Auxiliary working files can reside in dev/ and ignored in build.  

Secrets and environment variables (dummy examples are .env and auth_files/) should reside outside app/  
fileWatcher listens for local changes inside app/. Changes outside require container restart.
The first half of Makefile supports local development.  

The second half supports building the image and pushing it to a GCP artifact repository.  

Depending on your setup I find it simpler to authenticate a GCP user account and artifact repository and build push the image. Make commands do this.  gcloud SDK must already be configured.

Then deploy via cloud run service on GCP portal:  
Set up the relevant permissions for the compute engine default serivce account.  
In deploy options set environment variables and mount secrets in GCP secret manager as volumes.  
Can configure other service settings (CPU, timeout, etc.,).  
And deploy.

An alternative is to have environment variables and secrets all on GCP and authenticate a service account with permissions to access these in local development.  
The same service account can then be used to deploy the container direct from CLI.  

Can also set up continuous deployment via a github repo and github action.