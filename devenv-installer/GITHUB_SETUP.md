# GitHub Repository Setup Guide
## SUN DATA CONSULTING - Automation Scripts

This guide explains how to set up your GitHub repository for the automated installer distribution.

---

## Step 1: Create GitHub Repository

1. Go to [GitHub](https://github.com) and sign in
2. Click the **"+"** icon in the top right → **"New repository"**
3. Repository name: `automation-scripts` (or your preferred name)
4. Description: "Automation scripts for IT infrastructure and development environments"
5. Set to **Public** (or Private if you have GitHub Pro)
6. Check **"Add a README file"**
7. Click **"Create repository"**

---

## Step 2: Create Directory Structure

In your repository, create the following structure:

```
automation-scripts/
├── README.md (auto-created)
├── devenv-installer/
│   ├── install-config-gui.ps1
│   └── README.md
└── (other scripts in the future)
```

### How to create folders on GitHub:

1. Click **"Add file"** → **"Create new file"**
2. In the filename box, type: `devenv-installer/README.md`
3. GitHub will automatically create the `devenv-installer` folder
4. Add some content to README.md (you can copy from the local README.md)
5. Click **"Commit new file"**

---

## Step 3: Upload PowerShell Script

1. Navigate to the `devenv-installer` folder in your repository
2. Click **"Add file"** → **"Upload files"**
3. Drag and drop `install-config-gui.ps1` from your local computer
4. Add commit message: "Add development environment installer"
5. Click **"Commit changes"**

---

## Step 4: Configure the Batch Launcher

1. Open `launch-installer.bat` in a text editor
2. Find line 17: `SET "GITHUB_USER=YOUR_GITHUB_USERNAME"`
3. Replace `YOUR_GITHUB_USERNAME` with your actual GitHub username

**Example:**
```batch
SET "GITHUB_USER=sundataconsulting"
SET "GITHUB_REPO=automation-scripts"
SET "SCRIPT_PATH=devenv-installer/install-config-gui.ps1"
```

4. Save the file

---

## Step 5: Test the Setup

### Test URL Accessibility

1. Construct your raw GitHub URL:
   ```
   https://raw.githubusercontent.com/YOUR_USERNAME/automation-scripts/main/devenv-installer/install-config-gui.ps1
   ```

2. Open this URL in your browser
   - If you see the PowerShell script content → ✅ Success!
   - If you see "404 Not Found" → ❌ Check the path and repository settings

### Test the Batch Launcher

1. Right-click on `launch-installer.bat`
2. Select **"Run as administrator"**
3. The script should:
   - Download the PowerShell script from GitHub
   - Launch the GUI installer
   - Display the SUN DATA CONSULTING logo and branding

---

## Step 6: Distribution

### For End Users:

**Option 1: Direct Download Link**
Share this link with users:
```
https://github.com/YOUR_USERNAME/automation-scripts/raw/main/devenv-installer/launch-installer.bat
```

**Option 2: Release**
1. Go to your repository on GitHub
2. Click **"Releases"** → **"Create a new release"**
3. Tag version: `v1.0.0`
4. Release title: "Development Environment Installer v1.0.0"
5. Upload `launch-installer.bat` as an asset
6. Click **"Publish release"**
7. Share the release URL with users

---

## Updating the Installer

When you make changes to `install-config-gui.ps1`:

1. Upload the new version to GitHub (same location)
2. Commit the changes
3. **Users automatically get the latest version** - no need to redistribute the batch file!

---

## Customization

### Change Repository Name

If you want to use a different repository name:

1. Update line 18 in `launch-installer.bat`:
   ```batch
   SET "GITHUB_REPO=your-new-repo-name"
   ```

### Add More Scripts

You can add other automation scripts to your repository:

```
automation-scripts/
├── devenv-installer/
│   └── install-config-gui.ps1
├── server-setup/
│   └── configure-server.ps1
├── backup-scripts/
│   └── backup-databases.ps1
└── README.md
```

Each script can have its own batch launcher following the same pattern.

---

## Security Considerations

### Private Repositories

If your repository is private:
- Users will need a GitHub account with access
- Consider using GitHub Personal Access Tokens for authentication
- Or use GitHub Enterprise for your organization

### Code Signing

For production environments, consider:
- Signing your PowerShell scripts with a code signing certificate
- Using GitHub Actions to automate builds and releases
- Implementing checksum verification

---

## Troubleshooting

### "404 Not Found" when downloading

**Causes:**
- Incorrect GitHub username in batch file
- Incorrect repository name
- Incorrect file path
- Repository is private and not accessible

**Solution:**
1. Verify the URL in your browser
2. Check repository settings (Public vs Private)
3. Verify file exists at the specified path

### "Download failed" error

**Causes:**
- No internet connection
- GitHub is down (rare)
- Firewall blocking GitHub

**Solution:**
1. Check internet connection
2. Try accessing github.com in browser
3. Check firewall settings

---

## Next Steps

1. ✅ Create GitHub repository
2. ✅ Upload PowerShell script
3. ✅ Configure batch launcher
4. ✅ Test the setup
5. ✅ Distribute to users
6. 📊 Monitor usage and gather feedback
7. 🔄 Update and improve based on feedback

---

**Questions?** Open an issue on the GitHub repository.

**SUN DATA CONSULTING** - Automation Scripts
