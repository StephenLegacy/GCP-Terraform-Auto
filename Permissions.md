# Add the 'roles/compute.admin' role to the service account for managing compute resources
This command grants the service account permissions to manage compute instances, networks, etc.

Example: if your service account email is "my-service-account@astral-depth-443217-q6.iam.gserviceaccount.com",
replace "YOUR-SERVICE-ACCOUNT" with "my-service-account"

gcloud projects add-iam-policy-binding astral-depth-443217-q6 \
--member="serviceAccount:my-service-account@astral-depth-443217-q6.iam.gserviceaccount.com" \
--role="roles/compute.admin"

# Add the 'roles/owner' role to the service account for full project management permissions
Example: if your service account email is "my-service-account@astral-depth-443217-q6.iam.gserviceaccount.com",
replace "YOUR-SERVICE-ACCOUNT" with "my-service-account"

gcloud projects add-iam-policy-binding astral-depth-443217-q6 \
member="serviceAccount:my-service-account@astral-depth-443217-q6.iam.gserviceaccount.com" \
--role="roles/owner"

THE CODE

gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
  --member="serviceAccount:YOUR-SERVICE-ACCOUNT@YOUR-PROJECT.iam.gserviceaccount.com" \
  --role="roles/compute.admin"

gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
  --member="serviceAccount:YOUR-SERVICE-ACCOUNT@YOUR-PROJECT.iam.gserviceaccount.com" \
  --role="roles/owner"
