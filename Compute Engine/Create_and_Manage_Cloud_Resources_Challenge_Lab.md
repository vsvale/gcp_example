# Create a project jumphost instance
- Name the instance .
- Use an f1-micro machine type.
- Use the default image type (Debian Linux).

## Solution
- gcloud compute instances create nucleus-jumphost-634 --project=qwiklabs-gcp-01-3bb864e12727 --zone=us-west1-b --machine-type=f1-micro --network-interface=network-tier=PREMIUM,subnet=default --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=87366305027-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --create-disk=auto-delete=yes,boot=yes,device-name=nucleus-jumphost-634,image=projects/debian-cloud/global/images/debian-11-bullseye-v20221206,mode=rw,size=10,type=projects/qwiklabs-gcp-01-3bb864e12727/zones/us-west1-b/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

# Create a Kubernetes service cluster
- create a zonal cluster
- use the Docker container hello-app (gcr.io/google-samples/hello-app:2.0) as a placeholder; the team will replace the container with their own work later.
- Expose the app on port

## Solution
- gcloud container clusters create --machine-type=e2-medium --zone=us-west1-b challenge-cluster 
- kubectl create deployment hello-app --image=gcr.io/google-samples/hello-app:2.0
- kubectl expose deployment hello-app --type=LoadBalancer --port 8083

# Set up an HTTP load balancer
You will serve the site via nginx web servers, but you want to ensure that the environment is fault-tolerant. Create an HTTP load balancer with a managed instance group of 2 nginx web servers. Use the following code to configure the web servers; the team will replace this with their own configuration later.

## Create an instance template. 
- https://console.cloud.google.com/compute/instanceTemplates/list?_ga=2.148090997.339374917.1672272906-549437305.1667572785&_gac=1.27943886.1670847507.CjwKCAiAv9ucBhBXEiwA6N8nYL9W_oDj71W-DczEGE-AbGbU26JSJ1fQQCLVqrFrSZCskQrm1VeGxRoCNigQAvD_BwE
- gcloud compute instance-templates create lb-backend-template2 \
   --region= \
   --network=default \
   --subnet=default \
   --tags=allow-health-check \
   --machine-type=e2-medium \
   --image-family=debian-11 \
   --image-project=debian-cloud \
   --metadata=startup-script='#!/bin/bash
     apt-get update
     apt-get install apache2 -y
     apt-get install -y nginx
     service nginx start
     sed -i -- 's/nginx/Google Cloud Platform - '"\$HOSTNAME"'/' /var/www/html/index.nginx-debian.html
     a2ensite default-ssl
     a2enmod ssl
     vm_hostname="$(curl -H "Metadata-Flavor:Google" \
     http://169.254.169.254/computeMetadata/v1/instance/name)"
     echo "Page served from: $vm_hostname" | \
     tee /var/www/html/index.html
     systemctl restart apache2'
- gcloud compute firewall-rules create fw-allow-health-check \
  --network=default \
  --action=allow \
  --direction=ingress \
  --source-ranges=130.211.0.0/22,35.191.0.0/16 \
  --target-tags=allow-health-check \
  --rules=tcp:80



- gcloud compute instance-groups managed create lb-backend-group \
   --template=lb-backend-template --size=2
- Create a target pool.   gcloud compute target-pools create www-pool \
    --region  --http-health-check basic-check
- Create a managed instance group.
- Create a firewall rule named as to allow traffic (80/tcp).
- Create a health check.
- Create a backend service, and attach the managed instance group with named port (http:80).
- Create a URL map, and target the HTTP proxy to route requests to your URL map.
- Create a forwarding rule.


gcloud compute firewall-rules create allow-tcp-rule-750 \
  --network=default \
  --action=allow \
  --direction=ingress \
  --source-ranges=130.211.0.0/22,35.191.0.0/16 \
  --target-tags=allow-health-check \
  --rules=tcp:80
