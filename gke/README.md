# GKE

## Cost

Current configuration averages around $82.34. With the GKE free tier credit applied ($74.40), the final price per month is around $7.94.

```sh
# obtain access credentials for your user account
gcloud auth login
gcloud auth application-default login
gcloud container clusters get-credentials <CLUSTER>
```