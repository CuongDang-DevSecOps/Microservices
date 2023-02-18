DOCKER_USERNAME=$1
DOCKER_ACCESS_TOKEN=$2
DOCKER_HUB_REPOSITORY=$3
BUILD_VERSION=$4

echo "[DEBUG] current directory: $(pwd)"

echo "[DEBUG] maven version: $(mvn --version)"
echo "[DEBUG] Build Maven"
mvn clean install

echo "[DEBUG] docker version: $(docker --version)"
echo "[DEBUG] Build Image"
docker build -t test-server .

echo "[DEBUG] Tag Image $BUILD_VERSION"
docker tag test-server:latest "$DOCKER_HUB_REPOSITORY:$BUILD_VERSION"

echo "[DEBUG] docker sign-in $DOCKER_USERNAME"
echo "$DOCKER_ACCESS_TOKEN" | docker login --username "$DOCKER_USERNAME" --password-stdin

echo "[DEBUG] Push Image $DOCKER_HUB_REPOSITORY:$BUILD_VERSION"
docker push "$DOCKER_HUB_REPOSITORY:$BUILD_VERSION"