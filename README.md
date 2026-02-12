# SUN DATA CONSULTING
# Development Environment Installer

A bilingual (French/English) GUI installer for Windows development environment configuration with automated GitHub-based deployment.

---

## 🚀 Quick Start / Démarrage Rapide

### For End Users / Pour les Utilisateurs Finaux

**Simple 2-Step Installation:**

1. **Download** `launch-installer.bat` from the GitHub repository
2. **Right-click** on the file and select **"Run as administrator"** / **"Exécuter en tant qu'administrateur"**

That's it! The script will automatically:
- Download the latest installer from GitHub
- Configure PowerShell execution policy
- Launch the GUI installer

C'est tout ! Le script va automatiquement :
- Télécharger le dernier installateur depuis GitHub
- Configurer la politique d'exécution PowerShell
- Lancer l'installateur GUI

---

## 📦 What Gets Installed / Ce qui est Installé

The installer can install and configure:

- **Antigravity** - Modern code editor
- **Antigravity Plugins** - Terraform, Ansible, Kubernetes, Docker, GitLab, GitHub Actions
- **VirtualBox 7.2.0** - Virtualization platform
- **Vagrant 2.4.9** - Development environment manager
- **Vagrant Box** - sundataconsulting/ubuntu
- **CLI Tools:**
  - Terraform CLI
  - Ansible CLI (via Python pip)
  - Kubectl (Kubernetes CLI)
  - Docker CLI (via Docker Desktop)
  - GitLab CLI (glab)
  - GitHub CLI (gh)

---

## 🔧 For Repository Maintainers / Pour les Mainteneurs

### GitHub Repository Setup

1. **Create a GitHub repository** named `automation-scripts` (or your preferred name)

2. **Create the following directory structure:**
   ```
   automation-scripts/
   ├── devenv-installer/
   │   ├── install-config-gui.ps1
   │   └── README.md
   └── README.md
   ```

3. **Upload the files:**
   - Upload `install-config-gui.ps1` to the `devenv-installer/` folder
   - Commit and push to the `main` branch

4. **Configure the batch launcher:**
   - Edit `launch-installer.bat`
   - Update line 17: `SET "GITHUB_USER=YOUR_GITHUB_USERNAME"`
   - Replace `YOUR_GITHUB_USERNAME` with your actual GitHub username

5. **Distribute:**
   - Share only the `launch-installer.bat` file with end users
   - Users will always get the latest version from GitHub

### Customizing Company Branding

To customize the installer for your company:

1. **Company Name:**
   - Edit `install-config-gui.ps1`
   - Line 26: `$script:CompanyName = "YOUR COMPANY NAME"`

2. **Company Logo:**
   - Replace the base64 string on line 29 with your logo
   - To convert your logo to base64:
     ```powershell
     $bytes = [System.IO.File]::ReadAllBytes("path\to\your\logo.jpg")
     $base64 = [System.Convert]::ToBase64String($bytes)
     $base64 | Out-File logo-base64.txt
     ```
   - Copy the content and replace the value of `$script:CompanyLogoBase64`

3. **Colors:**
   - Edit line 590 to change the company name color:
     ```powershell
     $companyLabel.ForeColor = [System.Drawing.Color]::FromArgb(R, G, B)
     ```

---

## 📋 Features / Fonctionnalités

- ✅ **Bilingual Interface** - French and English
- ✅ **GitHub-Based** - Always up-to-date, single file distribution
- ✅ **Company Branding** - Logo and company name display
- ✅ **Selective Installation** - Choose which components to install
- ✅ **Progress Tracking** - Real-time installation progress
- ✅ **Error Handling** - Comprehensive error messages and logging
- ✅ **Automatic Cleanup** - Removes temporary files after installation

---

### 🖥️ Vagrant Stack Manager GUI

Interface graphique pour gérer vos environnements de développement.

**Fonctionnalités :**
- Découverte automatique des stacks depuis GitHub
- Affichage des logos de stack
- Start / Stop / Pause / Destroy en un clic
- Surveillance du statut en temps réel

**Lancement :**
Exécutez `vagrant-stack-manager/launch-stack-manager.bat` en tant qu'administrateur.

---

## 🛠️ Technical Requirements

- **Operating System:** Windows 10/11
- **PowerShell:** 5.1 or higher
- **Administrator Privileges:** Required
- **Internet Connection:** Required for downloading components

---

## 📝 Logs

Installation logs are saved to:
```
<script-directory>\installation-log.txt
```

---

## 🔐 Security

- The batch launcher uses HTTPS (TLS 1.2) for secure downloads
- PowerShell execution policy is set to `RemoteSigned` for security
- All downloads are from official sources (GitHub, HashiCorp, Oracle, etc.)

---

## 🆘 Troubleshooting / Dépannage

### Download Fails / Échec du Téléchargement

**Problem:** Script fails to download from GitHub

**Solutions:**
1. Check your internet connection
2. Verify the GitHub username in `launch-installer.bat` (line 17)
3. Ensure the repository is public or you have access
4. Check that the file path is correct (line 18)

### Antigravity Plugins Not Showing / Plugins Antigravity Invisibles

**Problem:** Plugins installed but not visible in Antigravity

**Solution:**
1. Close and reopen Antigravity
2. Check installed extensions: `antigravity --list-extensions`
3. Manually install if needed: `antigravity --install-extension <extension-id>`

### Administrator Privileges Error

**Problem:** "This script requires administrator privileges"

**Solution:**
- Right-click on `launch-installer.bat`
- Select "Run as administrator" / "Exécuter en tant qu'administrateur"

---

## 📞 Support

For issues or questions, please open an issue on the GitHub repository.

---

**SUN DATA CONSULTING** - Automation Scripts
