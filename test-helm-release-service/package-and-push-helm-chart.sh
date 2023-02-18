CHART_NAME=$1
BUILD_VERSION=$2
NAMESPACE=$3

echo "[DEBUG] current directory: $(pwd)"
echo "[DEBUG] helm version: $(helm version)"
helm package charts/"$CHART_NAME" --app-version "$BUILD_VERSION" --version "$BUILD_VERSION" -d charts/packages

echo "[DEBUG] Show package"
ls charts/packages

echo "[DEBUG] git version $(git version)"
git clone https://github.com/CuongDang-DevSecOps/GitOps-AgroCD

echo "[DEBUG] copy manifests to git-ops deploy $CHART_NAME"
cp charts/packages/* GitOps-AgroCD/helm-registry/packages/"$NAMESPACE"/

echo "[DEBUG] push to helm-registry"
cd GitOps-AgroCD || return
git status
git add .
git commit -m "chore: update $CHART_NAME:$BUILD_VERSION in $NAMESPACE"
git push

echo "[DEBUG] clean up"
cd ..
rm -rf GitOps-AgroCD