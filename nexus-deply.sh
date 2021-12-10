PACKAGE_NAME=$(node -p "require('./package.json').name")
PACKAGE_VERSION=$(node -p "require('./package.json').version")
# Build tag with version
docker build -t shultzlab.jfrog.io/default-docker-virtual/shultztom/$PACKAGE_NAME:$PACKAGE_VERSION .
#docker push shultzlab.jfrog.io/default-docker-virtual/shultztom/$PACKAGE_NAME:$PACKAGE_VERSION
# Tag with latest
docker tag shultzlab.jfrog.io/default-docker-virtual/shultztom/$PACKAGE_NAME:$PACKAGE_VERSION shultzlab.jfrog.io/default-docker-virtual/shultztom/$PACKAGE_NAME:latest
docker push shultzlab.jfrog.io/default-docker-virtual/shultztom/$PACKAGE_NAME:latest
echo 'Done pushing image'