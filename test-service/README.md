# Guideline

```
docker build -t test-service .
docker run -p 8080:8080 test-service
docker stop <container_id>
```

```
mkdir charts
helm create charts/test-service
helm lint charts/test-service
helm template --output-dir charts/manifests charts/test-service
```

```
helm package charts/test-service --app-version 1.0.0 --version 1.0.0 -d charts/packages
```