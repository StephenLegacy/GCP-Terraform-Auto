To successfully clone your GitHub repository into your cloud environment, follow these steps carefully:

---

### **1. Use SSH to Clone the Repository (Recommended)**
SSH eliminates the need to repeatedly input your credentials. Here's how to set it up:

1. **Generate an SSH Key Pair in the Cloud Environment**  
   Run the following command:
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```
   Press `Enter` to accept the default file location and set a passphrase (optional).

2. **Copy the SSH Public Key**  
   Copy the contents of your public key:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```

3. **Add the Key to Your GitHub Account**  
   - Go to GitHub.
   - Navigate to **Settings** > **SSH and GPG keys**.
   - Click **New SSH Key**, give it a title, and paste the copied key.

4. **Test the SSH Connection**  
   Run:
   ```bash
   ssh -T git@github.com
   ```
   It should say:
   ```
   Hi StephenLegacy! You've successfully authenticated, but GitHub does not provide shell access.
   ```

5. **Clone the Repository**  
   Use the SSH URL instead of HTTPS:
   ```bash
   git clone git@github.com:StephenLegacy/GCP-Terraform-Auto.git
   ```
6. Next, move into the directory resulting from the cloned repository e.g
```bash
   cd GCP-Terraform-Auto
   ```
---

### **2. Use HTTPS with Personal Access Token (If SSH is Not an Option)**
If you prefer HTTPS or SSH isn’t configured:

1. **Generate a Personal Access Token (PAT):**
   - Go to [GitHub Developer Settings](https://github.com/settings/tokens).
   - Generate a new token with the required permissions (e.g., `repo`).
   - Copy the token.

2. **Clone the Repository:**
   When prompted for your password, use the **token** instead:
   ```bash
   git clone https://github.com/StephenLegacy/terraform-gcp-deployments.git
   ```
   Enter `StephenLegacy` as the username and paste the PAT when asked for the password.

---

### **3. Troubleshoot Common Issues**
- **Permission Denied (SSH):** Ensure your SSH key is correctly added to GitHub.
- **Authentication Failed (HTTPS):** Double-check your username and PAT.
- **Repository Not Found:** Verify the repository URL and your access rights.


