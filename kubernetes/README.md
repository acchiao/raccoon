# Notes

```sh
# datadog secret
kubectl create secret generic datadog \
  --from-literal api-key=$DD_API_KEY \
  --from-literal app-key=$DD_APP_KEY
```
