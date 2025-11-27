.PHONY: up down build logs restart clean

#######################################################
################## local development ##################
#######################################################

#compose start container detached mode
up:
	docker-compose up -d

#stop the container
down:
	docker-compose down

#rebuild the image
#server file watches in app/ but need to rebuild other changes
build:
	docker-compose build

#see logs
logs:
	docker-compose logs -f

#clean volumes
clean:
	docker-compose down -v

#enter container shell
shell:
	docker compose exec streamlit-app bash

#######################################################
############## deploy on cloud run steps ##############
#######################################################

#GCP artifact registry details
GCP_PROJECT_ID = <>
GCP_REGION = <>
GCP_REPO_NAME = <>
IMAGE_NAME = <>
TAG = latest
USER = <>

ARTIFACT_URL = $(GCP_REGION)-docker.pkg.dev/$(GCP_PROJECT_ID)/$(GCP_REPO_NAME)/$(IMAGE_NAME):$(TAG)

#requires user account set up on GCP project [python-pipe] and gcloud sdk installed
user-auth:
	gcloud auth login

#user permissions to write image to artifact repo
registry-permissions:
	gcloud projects add-iam-policy-binding $(GCP_PROJECT_ID) \
   --member="user:$(USER)" \
    --role="roles/artifactregistry.writer"

#authenticate registry
registry-auth:
	gcloud auth configure-docker $(GCP_REGION).pkg.dev

#push image to registry
gcp-build:
	docker build -t $(ARTIFACT_URL) . 
	docker push $(ARTIFACT_URL)
	@echo "✅ Successfully pushed to: $(ARTIFACT_URL)"

#pull image from registry
pull-image:
	docker pull $(ARTIFACT_URL)