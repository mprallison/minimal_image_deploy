# Readme
This repo is setup to move easily from local development to deploying on cloud run  
Any working files can reside in dev/ and get ignored in build
Makefile commands support running the streamlit container locally, with ALL relevant files residing in app/  

Running locally, docker-compose adds gcp_secrets/ as an image volume, this lets the app interact with gdrive
Makefile has commands to authenticate the user and permissions to build and push image to a GCP artifact registry  

Deploying run doesn't need to worry about the local gdrive credentials at all! The default serivce account can run the app, it may need ot be granted further access to things like bigquery or a storage bucket, it basically looks for what it needs  

Passwords, API keys, etc should not go into the image build. These can be added as environment varibales or secrets on the cloud run deploy portal
