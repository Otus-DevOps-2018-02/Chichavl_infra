gcloud compute instances create reddit-fill \
    --tags=puma-server \
    --image-project=infra-197910 \
    --image-family=reddit-full \
    --zone=europe-west1-b