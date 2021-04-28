#!/bin/bash -xe

# A utility script to set up some of the environment variables, config and GCP services

export GCP_PROJECT_ID=$(gcloud config get-value project)

if [ -z "$GCP_PROJECT_ID" ]
    then
        echo "Please configure a project with: gcloud config set project [PROJECT_ID]"
        exit 1
fi

export GCP_REGION=us-central1

# Section: Prepare the Dependency Track images

gcloud services enable  artifactregistry.googleapis.com \
                        containerscanning.googleapis.com

gcloud config set artifacts/location $GCP_REGION
gcloud auth configure-docker $GCP_REGION-docker.pkg.dev

# Section: Deploy to Google Kubernetes Engine and Cloud SQL

gcloud services enable  compute.googleapis.com \
                        container.googleapis.com \
                        sql-component.googleapis.com \
                        sqladmin.googleapis.com \
                        secretmanager.googleapis.com \
                        servicenetworking.googleapis.com

gcloud config set compute/region $GCP_REGION
