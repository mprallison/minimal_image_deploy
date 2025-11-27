# Readme
A minimal example of developing a (web application) image locally to be deployed as a docker container on GCP cloud run.  
Example web app runs on streamlit but should be quite interchangeable with flask or node or whatever.  
Docker desktop must be up and running.

Auxiliary working files can reside in dev/ ignored in build.

Secrets and environment variables (dummy examples are .env and auth_files/) should reside outside build context (app/).  
These are configured in docker-compose.yml   
fileWatcher listens for local changes inside app/  
Changes outside require container restart.  

The first half of Makefile is for local development.  
The second half is for building and pushing the image to a GCP artifact registry repository.

Commands authenticate and set permissions for GCP user account and authenticate repository  
(User and repository only need to be authenticated once).  
Then build and push the image.

This anticipates:  
A GCP project has been created.  
You are added as a principal with at least Editor role permissions.  
A repository has been created in artifact registry.  
Google cloud SDK shell is up and running.

This is all you need to push images to be pulled by project users.  
Pull command is in Makefile (`make registry-auth` permits user to push and pull).  

To deploy container via cloud run:  
Set up the relevant permissions for the compute engine default service account  
(Cloud Run Admin, Secret Manager Secret Accessor plus whatever permissions required locally).  
In cloud run service deploy options, set environment variables and mount secrets via GCP secret manager as volumes.  
Can configure other service settings (CPUs, timeout, etc.,).  
Deploy.

An alternative is to have environment variables and secrets managed on GCP throughout development.  
Authenticate a service account with permissions to access them locally.  
Then can use the same service account to deploy the container direct from CLI.

Can also do continuous deployment via a github repo and github action.

In a real project .env, secrets etc., should be added to .gitignore!