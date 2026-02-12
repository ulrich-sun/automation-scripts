#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Bilingual GUI installer for development environment configuration
    Installateur GUI bilingue pour la configuration d'environnement de développement

.DESCRIPTION
    Windows Forms GUI application to install and configure:
    - Antigravity
    - VirtualBox 7.2.0
    - Vagrant 2.4.9
    - CLI Tools (Terraform, Ansible, kubectl, Docker, GitLab, GitHub)
    - Antigravity Plugins
    - Vagrant Box (sundataconsulting/ubuntu)

.NOTES
    Author: Antigravity Assistant
    Requires: PowerShell 5.1+ and Administrator privileges
#>

# Global variables
$script:Language = "FR"
$script:LogFile = "$PSScriptRoot\installation-log.txt"
$script:TempDir = "$env:TEMP\DevEnvInstaller"
$script:CompanyName = "SUN DATA CONSULTING"

# Company Logo (Base64 encoded)
$script:CompanyLogoBase64 = "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"

# Helper function to convert base64 to image
function ConvertFrom-Base64ToImage {
    param([string]$Base64String)
    try {
        $imageBytes = [Convert]::FromBase64String($Base64String)
        $ms = New-Object IO.MemoryStream($imageBytes, 0, $imageBytes.Length)
        $ms.Write($imageBytes, 0, $imageBytes.Length)
        $image = [System.Drawing.Image]::FromStream($ms, $true)
        return $image
    }
    catch {
        Write-Log "Failed to load company logo: $_" -Level "WARN"
        return $null
    }
}

# Translation dictionary
$script:Translations = @{
    FR = @{
        Title = "Installateur de Configuration de Développement"
        LanguageLabel = "Langue / Language:"
        SelectAll = "Tout sélectionner"
        DeselectAll = "Tout désélectionner"
        Install = "Installer"
        Cancel = "Annuler"
        Progress = "Progression:"
        Status = "Statut:"
        Ready = "Prêt à installer"
        Installing = "Installation en cours..."
        Complete = "Installation terminée!"
        Error = "Erreur lors de l'installation"
        CheckInternet = "Vérification de la connexion Internet..."
        CheckAdmin = "Vérification des privilèges administrateur..."
        Downloading = "Téléchargement de {0}..."
        Installing_Item = "Installation de {0}..."
        Success = "{0} installé avec succès"
        Failed = "Échec de l'installation de {0}"
        LogSaved = "Journal sauvegardé dans: {0}"
        
        # Component names
        Antigravity = "Antigravity"
        AntigravityPlugins = "Plugins Antigravity (Terraform, Ansible, K8s, Docker, GitLab, GitHub)"
        VirtualBox = "VirtualBox 7.2.0"
        Vagrant = "Vagrant 2.4.9"
        VagrantBox = "Vagrant Box (sundataconsulting/ubuntu)"
        TerraformCLI = "Terraform CLI"
        AnsibleCLI = "Ansible CLI"
        KubectlCLI = "Kubectl (Kubernetes CLI)"
        DockerCLI = "Docker CLI"
        GitLabCLI = "GitLab CLI (glab)"
        GitHubCLI = "GitHub CLI (gh)"
    }
    EN = @{
        Title = "Development Configuration Installer"
        LanguageLabel = "Language / Langue:"
        SelectAll = "Select All"
        DeselectAll = "Deselect All"
        Install = "Install"
        Cancel = "Cancel"
        Progress = "Progress:"
        Status = "Status:"
        Ready = "Ready to install"
        Installing = "Installing..."
        Complete = "Installation complete!"
        Error = "Installation error"
        CheckInternet = "Checking internet connection..."
        CheckAdmin = "Checking administrator privileges..."
        Downloading = "Downloading {0}..."
        Installing_Item = "Installing {0}..."
        Success = "{0} installed successfully"
        Failed = "Failed to install {0}"
        LogSaved = "Log saved to: {0}"
        
        # Component names
        Antigravity = "Antigravity"
        AntigravityPlugins = "Antigravity Plugins (Terraform, Ansible, K8s, Docker, GitLab, GitHub)"
        VirtualBox = "VirtualBox 7.2.0"
        Vagrant = "Vagrant 2.4.9"
        VagrantBox = "Vagrant Box (sundataconsulting/ubuntu)"
        TerraformCLI = "Terraform CLI"
        AnsibleCLI = "Ansible CLI"
        KubectlCLI = "Kubectl (Kubernetes CLI)"
        DockerCLI = "Docker CLI"
        GitLabCLI = "GitLab CLI (glab)"
        GitHubCLI = "GitHub CLI (gh)"
    }
}

# Helper function to get translated text
function Get-Translation {
    param([string]$Key)
    return $script:Translations[$script:Language][$Key]
}

# Logging function
function Write-Log {
    param(
        [string]$Message,
        [string]$Level = "INFO"
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] [$Level] $Message"
    Add-Content -Path $script:LogFile -Value $logMessage
    Write-Host $logMessage
}

# Update status in GUI
function Update-Status {
    param(
        [string]$Message,
        [int]$ProgressValue = -1
    )
    $statusLabel.Text = "$(Get-Translation 'Status') $Message"
    if ($ProgressValue -ge 0) {
        $progressBar.Value = $ProgressValue
    }
    $form.Refresh()
    Write-Log $Message
}

# Download file with progress
function Download-File {
    param(
        [string]$Url,
        [string]$OutputPath
    )
    try {
        Write-Log "Downloading from $Url to $OutputPath"
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFile($Url, $OutputPath)
        return $true
    }
    catch {
        Write-Log "Download failed: $_" -Level "ERROR"
        return $false
    }
}

# Add to PATH
function Add-ToPath {
    param([string]$PathToAdd)
    
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    if ($currentPath -notlike "*$PathToAdd*") {
        [Environment]::SetEnvironmentVariable("Path", "$currentPath;$PathToAdd", "Machine")
        Write-Log "Added to PATH: $PathToAdd"
    }
}

# Installation Functions

function Install-Antigravity {
    Update-Status (Get-Translation 'Installing_Item' -f "Antigravity") 10
    
    try {
        # Using winget to install Antigravity (adjust if different method needed)
        $result = winget install --id Google.Antigravity --silent --accept-package-agreements --accept-source-agreements 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Log "Antigravity installed successfully"
            return $true
        }
        else {
            Write-Log "Antigravity installation failed: $result" -Level "ERROR"
            return $false
        }
    }
    catch {
        Write-Log "Antigravity installation error: $_" -Level "ERROR"
        return $false
    }
}

function Install-AntigravityPlugins {
    Update-Status (Get-Translation 'Installing_Item' -f "Antigravity Plugins") 15
    
    try {
        # Install Antigravity extensions using the correct CLI command
        # Map of plugin names to their extension IDs
        $plugins = @{
            "terraform" = "hashicorp.terraform"
            "ansible" = "redhat.ansible"
            "kubernetes" = "ms-kubernetes-tools.vscode-kubernetes-tools"
            "docker" = "ms-azuretools.vscode-docker"
            "gitlab" = "gitlab.gitlab-workflow"
            "github-actions" = "github.vscode-github-actions"
        }
        
        foreach ($pluginName in $plugins.Keys) {
            $extensionId = $plugins[$pluginName]
            Write-Log "Installing Antigravity plugin: $pluginName ($extensionId)"
            
            # Use the correct Antigravity CLI command to install extensions
            $result = & antigravity --install-extension $extensionId --force 2>&1
            
            if ($LASTEXITCODE -eq 0) {
                Write-Log "Successfully installed plugin: $pluginName"
            } else {
                Write-Log "Warning: Plugin $pluginName installation may have failed: $result" -Level "WARN"
            }
        }
        
        return $true
    }
    catch {
        Write-Log "Antigravity plugins installation error: $_" -Level "ERROR"
        return $false
    }
}

function Install-VirtualBox {
    Update-Status (Get-Translation 'Installing_Item' -f "VirtualBox 7.2.0") 20
    
    try {
        $vboxUrl = "https://download.virtualbox.org/virtualbox/7.2.0/VirtualBox-7.2.0-164728-Win.exe"
        $vboxInstaller = "$script:TempDir\VirtualBox-7.2.0.exe"
        
        Update-Status (Get-Translation 'Downloading' -f "VirtualBox") 22
        if (-not (Download-File $vboxUrl $vboxInstaller)) {
            return $false
        }
        
        Update-Status (Get-Translation 'Installing_Item' -f "VirtualBox") 25
        $process = Start-Process -FilePath $vboxInstaller -ArgumentList "--silent" -Wait -PassThru
        
        if ($process.ExitCode -eq 0) {
            Write-Log "VirtualBox 7.2.0 installed successfully"
            return $true
        }
        else {
            Write-Log "VirtualBox installation failed with exit code: $($process.ExitCode)" -Level "ERROR"
            return $false
        }
    }
    catch {
        Write-Log "VirtualBox installation error: $_" -Level "ERROR"
        return $false
    }
}

function Install-Vagrant {
    Update-Status (Get-Translation 'Installing_Item' -f "Vagrant 2.4.9") 30
    
    try {
        $vagrantUrl = "https://releases.hashicorp.com/vagrant/2.4.9/vagrant_2.4.9_windows_amd64.msi"
        $vagrantInstaller = "$script:TempDir\vagrant_2.4.9.msi"
        
        Update-Status (Get-Translation 'Downloading' -f "Vagrant") 32
        if (-not (Download-File $vagrantUrl $vagrantInstaller)) {
            return $false
        }
        
        Update-Status (Get-Translation 'Installing_Item' -f "Vagrant") 35
        $process = Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$vagrantInstaller`" /quiet /norestart" -Wait -PassThru
        
        if ($process.ExitCode -eq 0) {
            Write-Log "Vagrant 2.4.9 installed successfully"
            return $true
        }
        else {
            Write-Log "Vagrant installation failed with exit code: $($process.ExitCode)" -Level "ERROR"
            return $false
        }
    }
    catch {
        Write-Log "Vagrant installation error: $_" -Level "ERROR"
        return $false
    }
}

function Install-VagrantBox {
    Update-Status (Get-Translation 'Installing_Item' -f "Vagrant Box") 40
    
    try {
        # Add Vagrant box from HashiCorp Cloud
        $boxName = "sundataconsulting/ubuntu"
        Write-Log "Adding Vagrant box: $boxName"
        
        $process = Start-Process -FilePath "vagrant" -ArgumentList "box add $boxName --provider virtualbox" -Wait -PassThru -NoNewWindow
        
        if ($process.ExitCode -eq 0) {
            Write-Log "Vagrant box $boxName added successfully"
            return $true
        }
        else {
            Write-Log "Vagrant box installation failed with exit code: $($process.ExitCode)" -Level "ERROR"
            return $false
        }
    }
    catch {
        Write-Log "Vagrant box installation error: $_" -Level "ERROR"
        return $false
    }
}

function Install-Terraform {
    Update-Status (Get-Translation 'Installing_Item' -f "Terraform") 50
    
    try {
        # Get latest Terraform version
        $terraformUrl = "https://releases.hashicorp.com/terraform/1.7.4/terraform_1.7.4_windows_amd64.zip"
        $terraformZip = "$script:TempDir\terraform.zip"
        $terraformDir = "C:\Program Files\Terraform"
        
        Update-Status (Get-Translation 'Downloading' -f "Terraform") 52
        if (-not (Download-File $terraformUrl $terraformZip)) {
            return $false
        }
        
        # Extract and install
        New-Item -ItemType Directory -Path $terraformDir -Force | Out-Null
        Expand-Archive -Path $terraformZip -DestinationPath $terraformDir -Force
        Add-ToPath $terraformDir
        
        Write-Log "Terraform installed successfully"
        return $true
    }
    catch {
        Write-Log "Terraform installation error: $_" -Level "ERROR"
        return $false
    }
}

function Install-Ansible {
    Update-Status (Get-Translation 'Installing_Item' -f "Ansible") 55
    
    try {
        # Install Python if not present, then install Ansible via pip
        # Check if Python is installed
        $pythonCheck = Get-Command python -ErrorAction SilentlyContinue
        
        if (-not $pythonCheck) {
            Write-Log "Python not found. Installing Python first..."
            winget install --id Python.Python.3.12 --silent --accept-package-agreements --accept-source-agreements
        }
        
        # Install Ansible via pip
        $process = Start-Process -FilePath "python" -ArgumentList "-m pip install ansible --quiet" -Wait -PassThru -NoNewWindow
        
        if ($process.ExitCode -eq 0) {
            Write-Log "Ansible installed successfully"
            return $true
        }
        else {
            Write-Log "Ansible installation failed" -Level "ERROR"
            return $false
        }
    }
    catch {
        Write-Log "Ansible installation error: $_" -Level "ERROR"
        return $false
    }
}

function Install-Kubectl {
    Update-Status (Get-Translation 'Installing_Item' -f "kubectl") 60
    
    try {
        $kubectlUrl = "https://dl.k8s.io/release/v1.29.2/bin/windows/amd64/kubectl.exe"
        $kubectlDir = "C:\Program Files\kubectl"
        $kubectlPath = "$kubectlDir\kubectl.exe"
        
        Update-Status (Get-Translation 'Downloading' -f "kubectl") 62
        New-Item -ItemType Directory -Path $kubectlDir -Force | Out-Null
        
        if (-not (Download-File $kubectlUrl $kubectlPath)) {
            return $false
        }
        
        Add-ToPath $kubectlDir
        Write-Log "kubectl installed successfully"
        return $true
    }
    catch {
        Write-Log "kubectl installation error: $_" -Level "ERROR"
        return $false
    }
}

function Install-DockerCLI {
    Update-Status (Get-Translation 'Installing_Item' -f "Docker CLI") 65
    
    try {
        # Install Docker Desktop which includes CLI
        $result = winget install --id Docker.DockerDesktop --silent --accept-package-agreements --accept-source-agreements 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Log "Docker CLI installed successfully"
            return $true
        }
        else {
            Write-Log "Docker CLI installation failed: $result" -Level "ERROR"
            return $false
        }
    }
    catch {
        Write-Log "Docker CLI installation error: $_" -Level "ERROR"
        return $false
    }
}

function Install-GitLabCLI {
    Update-Status (Get-Translation 'Installing_Item' -f "GitLab CLI") 70
    
    try {
        # Install glab (GitLab CLI)
        $result = winget install --id GitLab.glab --silent --accept-package-agreements --accept-source-agreements 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Log "GitLab CLI (glab) installed successfully"
            return $true
        }
        else {
            Write-Log "GitLab CLI installation failed: $result" -Level "ERROR"
            return $false
        }
    }
    catch {
        Write-Log "GitLab CLI installation error: $_" -Level "ERROR"
        return $false
    }
}

function Install-GitHubCLI {
    Update-Status (Get-Translation 'Installing_Item' -f "GitHub CLI") 75
    
    try {
        # Install gh (GitHub CLI)
        $result = winget install --id GitHub.cli --silent --accept-package-agreements --accept-source-agreements 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Log "GitHub CLI (gh) installed successfully"
            return $true
        }
        else {
            Write-Log "GitHub CLI installation failed: $result" -Level "ERROR"
            return $false
        }
    }
    catch {
        Write-Log "GitHub CLI installation error: $_" -Level "ERROR"
        return $false
    }
}

# Main installation orchestrator
function Start-Installation {
    $installButton.Enabled = $false
    $progressBar.Value = 0
    
    # Create temp directory
    if (-not (Test-Path $script:TempDir)) {
        New-Item -ItemType Directory -Path $script:TempDir -Force | Out-Null
    }
    
    Write-Log "=== Installation Started ==="
    Update-Status (Get-Translation 'Installing') 5
    
    $totalSteps = 0
    $completedSteps = 0
    
    # Count selected items
    foreach ($checkbox in $checkboxes.Values) {
        if ($checkbox.Checked) { $totalSteps++ }
    }
    
    # Install selected components
    try {
        if ($checkboxes['Antigravity'].Checked) {
            if (Install-Antigravity) { $completedSteps++ }
        }
        
        if ($checkboxes['AntigravityPlugins'].Checked) {
            if (Install-AntigravityPlugins) { $completedSteps++ }
        }
        
        if ($checkboxes['VirtualBox'].Checked) {
            if (Install-VirtualBox) { $completedSteps++ }
        }
        
        if ($checkboxes['Vagrant'].Checked) {
            if (Install-Vagrant) { $completedSteps++ }
        }
        
        if ($checkboxes['VagrantBox'].Checked) {
            if (Install-VagrantBox) { $completedSteps++ }
        }
        
        if ($checkboxes['TerraformCLI'].Checked) {
            if (Install-Terraform) { $completedSteps++ }
        }
        
        if ($checkboxes['AnsibleCLI'].Checked) {
            if (Install-Ansible) { $completedSteps++ }
        }
        
        if ($checkboxes['KubectlCLI'].Checked) {
            if (Install-Kubectl) { $completedSteps++ }
        }
        
        if ($checkboxes['DockerCLI'].Checked) {
            if (Install-DockerCLI) { $completedSteps++ }
        }
        
        if ($checkboxes['GitLabCLI'].Checked) {
            if (Install-GitLabCLI) { $completedSteps++ }
        }
        
        if ($checkboxes['GitHubCLI'].Checked) {
            if (Install-GitHubCLI) { $completedSteps++ }
        }
        
        # Complete
        $progressBar.Value = 100
        Update-Status (Get-Translation 'Complete') 100
        Write-Log "=== Installation Completed: $completedSteps/$totalSteps successful ==="
        
        [System.Windows.Forms.MessageBox]::Show(
            (Get-Translation 'Complete') + "`n" + (Get-Translation 'LogSaved' -f $script:LogFile),
            (Get-Translation 'Title'),
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Information
        )
    }
    catch {
        Write-Log "Installation error: $_" -Level "ERROR"
        Update-Status (Get-Translation 'Error')
        [System.Windows.Forms.MessageBox]::Show(
            (Get-Translation 'Error') + ": $_",
            (Get-Translation 'Title'),
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        )
    }
    finally {
        $installButton.Enabled = $true
    }
}

# Create GUI
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = Get-Translation 'Title'
$form.Size = New-Object System.Drawing.Size(600, 800)  # Increased height for branding
$form.StartPosition = 'CenterScreen'
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false

# Company Logo
$logoPictureBox = New-Object System.Windows.Forms.PictureBox
$logoPictureBox.Location = New-Object System.Drawing.Point(20, 15)
$logoPictureBox.Size = New-Object System.Drawing.Size(100, 100)
$logoPictureBox.SizeMode = 'Zoom'
$logoImage = ConvertFrom-Base64ToImage $script:CompanyLogoBase64
if ($logoImage) {
    $logoPictureBox.Image = $logoImage
}
$form.Controls.Add($logoPictureBox)

# Company Name Label
$companyLabel = New-Object System.Windows.Forms.Label
$companyLabel.Location = New-Object System.Drawing.Point(130, 35)
$companyLabel.Size = New-Object System.Drawing.Size(450, 35)
$companyLabel.Text = $script:CompanyName
$companyLabel.Font = New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)
$companyLabel.ForeColor = [System.Drawing.Color]::FromArgb(0, 102, 153)  # Blue color matching logo
$form.Controls.Add($companyLabel)

# Tagline Label
$taglineLabel = New-Object System.Windows.Forms.Label
$taglineLabel.Location = New-Object System.Drawing.Point(130, 70)
$taglineLabel.Size = New-Object System.Drawing.Size(450, 20)
$taglineLabel.Text = "Development Environment Installer"
$taglineLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Italic)
$taglineLabel.ForeColor = [System.Drawing.Color]::Gray
$form.Controls.Add($taglineLabel)

# Separator line
$separator = New-Object System.Windows.Forms.Label
$separator.Location = New-Object System.Drawing.Point(10, 120)
$separator.Size = New-Object System.Drawing.Size(560, 2)
$separator.BorderStyle = 'Fixed3D'
$form.Controls.Add($separator)

# Language selector (moved down)
$langLabel = New-Object System.Windows.Forms.Label
$langLabel.Location = New-Object System.Drawing.Point(10, 135)
$langLabel.Size = New-Object System.Drawing.Size(120, 20)
$langLabel.Text = "Langue / Language:"
$form.Controls.Add($langLabel)

$langCombo = New-Object System.Windows.Forms.ComboBox
$langCombo.Location = New-Object System.Drawing.Point(140, 135)
$langCombo.Size = New-Object System.Drawing.Size(100, 20)
$langCombo.DropDownStyle = 'DropDownList'
$langCombo.Items.AddRange(@('Français', 'English'))
$langCombo.SelectedIndex = 0

$langCombo.Add_SelectedIndexChanged({
    if ($langCombo.SelectedIndex -eq 0) {
        $script:Language = "FR"
    } else {
        $script:Language = "EN"
    }
    # Update all labels
    $form.Text = Get-Translation 'Title'
    $selectAllBtn.Text = Get-Translation 'SelectAll'
    $deselectAllBtn.Text = Get-Translation 'DeselectAll'
    $installButton.Text = Get-Translation 'Install'
    $cancelButton.Text = Get-Translation 'Cancel'
    $progressLabel.Text = Get-Translation 'Progress'
    $statusLabel.Text = "$(Get-Translation 'Status') $(Get-Translation 'Ready')"
    
    # Update checkbox labels
    foreach ($key in $checkboxes.Keys) {
        $checkboxes[$key].Text = Get-Translation $key
    }
})
$form.Controls.Add($langCombo)

# Checkboxes panel (adjusted position)
$checkboxPanel = New-Object System.Windows.Forms.Panel
$checkboxPanel.Location = New-Object System.Drawing.Point(10, 170)
$checkboxPanel.Size = New-Object System.Drawing.Size(560, 400)
$checkboxPanel.BorderStyle = 'FixedSingle'
$checkboxPanel.AutoScroll = $true
$form.Controls.Add($checkboxPanel)

# Create checkboxes
$script:checkboxes = @{}
$yPos = 10
$componentKeys = @(
    'Antigravity', 'AntigravityPlugins', 'VirtualBox', 'Vagrant', 'VagrantBox',
    'TerraformCLI', 'AnsibleCLI', 'KubectlCLI', 'DockerCLI', 'GitLabCLI', 'GitHubCLI'
)

foreach ($key in $componentKeys) {
    $checkbox = New-Object System.Windows.Forms.CheckBox
    $checkbox.Location = New-Object System.Drawing.Point(10, $yPos)
    $checkbox.Size = New-Object System.Drawing.Size(520, 30)
    $checkbox.Text = Get-Translation $key
    $checkbox.Checked = $true
    $checkboxPanel.Controls.Add($checkbox)
    $script:checkboxes[$key] = $checkbox
    $yPos += 35
}

# Select/Deselect buttons (adjusted position)
$selectAllBtn = New-Object System.Windows.Forms.Button
$selectAllBtn.Location = New-Object System.Drawing.Point(10, 580)
$selectAllBtn.Size = New-Object System.Drawing.Size(120, 30)
$selectAllBtn.Text = Get-Translation 'SelectAll'
$selectAllBtn.Add_Click({
    foreach ($checkbox in $checkboxes.Values) {
        $checkbox.Checked = $true
    }
})
$form.Controls.Add($selectAllBtn)

$deselectAllBtn = New-Object System.Windows.Forms.Button
$deselectAllBtn.Location = New-Object System.Drawing.Point(140, 580)
$deselectAllBtn.Size = New-Object System.Drawing.Size(120, 30)
$deselectAllBtn.Text = Get-Translation 'DeselectAll'
$deselectAllBtn.Add_Click({
    foreach ($checkbox in $checkboxes.Values) {
        $checkbox.Checked = $false
    }
})
$form.Controls.Add($deselectAllBtn)

# Progress bar (adjusted position)
$progressLabel = New-Object System.Windows.Forms.Label
$progressLabel.Location = New-Object System.Drawing.Point(10, 625)
$progressLabel.Size = New-Object System.Drawing.Size(100, 20)
$progressLabel.Text = Get-Translation 'Progress'
$form.Controls.Add($progressLabel)

$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(10, 650)
$progressBar.Size = New-Object System.Drawing.Size(560, 25)
$form.Controls.Add($progressBar)

# Status label (adjusted position)
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Location = New-Object System.Drawing.Point(10, 685)
$statusLabel.Size = New-Object System.Drawing.Size(560, 40)
$statusLabel.Text = "$(Get-Translation 'Status') $(Get-Translation 'Ready')"
$form.Controls.Add($statusLabel)

# Install button (adjusted position)
$installButton = New-Object System.Windows.Forms.Button
$installButton.Location = New-Object System.Drawing.Point(350, 740)
$installButton.Size = New-Object System.Drawing.Size(100, 35)
$installButton.Text = Get-Translation 'Install'
$installButton.Add_Click({ Start-Installation })
$form.Controls.Add($installButton)

# Cancel button (adjusted position)
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(470, 740)
$cancelButton.Size = New-Object System.Drawing.Size(100, 35)
$cancelButton.Text = Get-Translation 'Cancel'
$cancelButton.Add_Click({ $form.Close() })
$form.Controls.Add($cancelButton)

# Initialize log
Write-Log "=== Development Environment Installer Started ==="

# Show form
[void]$form.ShowDialog()
