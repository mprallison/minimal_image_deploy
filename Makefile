.PHONY: up down build logs clean shell user-auth registry-permissions registry-auth gcp-build pull-image

#######################################################
################## local development ##################
#######################################################

#compose start container detached mode
up:
	docker-compose up -d

#stop the container
down:
	docker-compose down

#build the image
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
################# deploy on cloud run #################
#######################################################

#GCP project >> artifact registry >> repository >> image details
GCP_PROJECT_ID = <>
GCP_REGION = <>
GCP_REPO_NAME = <>
IMAGE_NAME = <>
TAG = latest
USER = <>

ARTIFACT_URL = $(GCP_REGION)-docker.pkg.dev/$(GCP_PROJECT_ID)/$(GCP_REPO_NAME)/$(IMAGE_NAME):$(TAG)

#authenticate user
user-auth:
	gcloud auth login

#user permissions to write image to artifact repo
user-permissions:
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
