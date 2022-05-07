PACKAGE_NAME=$(node -p "require('./package.json').name")
PACKAGE_VERSION=$(node -p "require('./package.json').version")
# Build tag with version
docker build -t us-central1-docker.pkg.dev/shultzlab/docker-gcp/$PACKAGE_NAME:$PACKAGE_VERSION .
docker push us-central1-docker.pkg.dev/shultzlab/docker-gcp/$PACKAGE_NAME:$PACKAGE_VERSION
# Tag with latest
docker tag us-central1-docker.pkg.dev/shultzlab/docker-gcp/$PACKAGE_NAME:$PACKAGE_VERSION us-central1-docker.pkg.dev/shultzlab/docker-gcp/$PACKAGE_NAME:latest
docker push us-central1-docker.pkg.dev/shultzlab/docker-gcp/$PACKAGE_NAME:latest
echo 'Done pushing image'