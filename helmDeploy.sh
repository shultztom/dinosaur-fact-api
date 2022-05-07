gcloud auth print-access-token | helm registry login -u oauth2accesstoken \
--password-stdin https://us-central1-docker.pkg.dev

helm upgrade --install dino-facts-api oci://us-central1-docker.pkg.dev/shultzlab/shultzlab-helm/http-deploy --version 0.1.0 -f .helm/deploy/values.yaml