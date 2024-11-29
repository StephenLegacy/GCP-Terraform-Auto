
---

# Terraform GCP Deployment with Load Balancing and Web Servers  
**By Stephen Oloo**  

This repository contains Terraform code to provision scalable and automated infrastructure on Google Cloud Platform (GCP). It includes setting up a custom Virtual Private Cloud (VPC), deploying multiple instances with web servers, and configuring a load balancer for high availability. All steps are designed to be executed from the GCP Cloud Shell or any terminal with access to GCP.

---

## Features  

- **Custom VPC and Subnet**: Creates a custom VPC and subnet for isolated infrastructure.  
- **Firewall Rules**: Allows HTTP traffic to the instances securely.  
- **Compute Instances**: Provisions multiple VM instances with Apache web servers installed.  
- **Load Balancer**: Configures an HTTP load balancer to distribute traffic across instances.  
- **Scalability**: Easily adjust the number of instances with a single variable.  
- **Infrastructure as Code (IaC)**: Uses Terraform to ensure repeatable, consistent deployments.  

---

## Prerequisites  

1. Access to **Google Cloud Console**.  
2. A project with **billing enabled**.  
3. **Terraform pre-installed** on the Cloud Shell (or run `sudo apt install terraform` to install it).  
4. Proper **IAM roles** for creating resources, such as `Owner` or `Editor`.  

---

## Deployment Steps  

### Step 1: Open Cloud Shell  
1. Open the Google Cloud Console.  
2. Launch the Cloud Shell by clicking the terminal icon in the top-right corner.  

### Step 2: Clone the Repository  
Clone this repository into your Cloud Shell environment:  
```bash
git clone https://github.com/StephenLegacy/terraform-gcp-deployments.git
cd terraform-gcp-deployments
```

### Step 3: Configure Your Project Variables  
Edit the `terraform.tfvars` file with your project details:  
```bash
nano terraform.tfvars
```
Replace the placeholders with your project-specific values:  
```hcl
project_id = "your-gcp-project-id"
region     = "us-central1"
```
Save and exit (`Ctrl + O`, then `Ctrl + X`).

### Step 4: Initialize Terraform  
Run the following command to initialize Terraform in the directory:  
```bash
terraform init
```

### Step 5: Review the Plan  
Preview the resources Terraform will create:  
```bash
terraform plan
```

### Step 6: Deploy the Infrastructure  
Apply the configuration to provision the resources:  
```bash
terraform apply
```
Type `yes` when prompted to confirm the deployment.

### Step 7: Access the Load Balancer  
After successful deployment, Terraform will output the public IP of the load balancer.  
Open this IP address in your browser to access the web servers.

---

## Project Structure  

```
terraform-gcp-deployments/
├── main.tf            # Core infrastructure definition
├── variables.tf       # Input variables
├── outputs.tf         # Output definitions
├── scripts/
│   └── install_web.sh # Script to install Apache on instances
├── README.md          # Project documentation
```

---

## Customization  

- **Instance Count**: Adjust the number of VM instances by modifying the `instance_count` variable in `variables.tf`.  
- **Machine Type**: Use a different machine type by setting the `machine_type` variable.  

---

## Cleanup  

To destroy all resources and avoid incurring costs, run:  
```bash
terraform destroy
```
Type `yes` to confirm the destruction.

---

## Notes  

- Ensure all resources are destroyed after testing to avoid unnecessary charges.  
- For real-time monitoring, use the **GCP Console** or `gcloud` CLI commands.

---

## License  

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---


