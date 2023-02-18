CHART_NAME=$1
BUILD_VERSION=$2

echo "[DEBUG] current directory: $(pwd)"
echo "[DEBUG] helm version: $(helm version)"
helm lint charts/test-service
helm template --output-dir charts/manifests charts/test-service

echo "[DEBUG] Replace <IMAGE_TAG> $BUILD_VERSION"
sed -i "s/<IMAGE_TAG>/$BUILD_VERSION/g" charts/manifests/"$CHART_NAME"/templates/deployment.yaml

echo "[DEBUG] Show manifests"
cat charts/manifests/"$CHART_NAME"/templates/*.yaml

echo "[DEBUG] git version $(git version)"
git clone https://github.com/CuongDang-DevSecOps/GitOps-AgroCD

echo "[DEBUG] copy manifests to git-ops deploy $CHART_NAME"
cp charts/manifests/"$CHART_NAME"/templates/* GitOps-AgroCD/git-ops/deploy/test-k8s-manifest/"$CHART_NAME"/

echo "[DEBUG] push to git-ops"
cd GitOps-AgroCD || return
git status
git add .
git commit -m "chore: update $CHART_NAME:$BUILD_VERSION"
git push

echo "[DEBUG] clean up"
cd ..
rm -rf GitOps-AgroCD