#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Vagrant Stack Manager GUI for SUN DATA CONSULTING
    Gestionnaire de Stacks Vagrant pour SUN DATA CONSULTING

.DESCRIPTION
    GUI to manage Vagrant stacks from the company repository.
    Interface graphique pour gérer les stacks Vagrant du dépôt d'entreprise.

.NOTES
    Author: Antigravity
    Company: SUN DATA CONSULTING
#>

# Configure Console Encoding (for accents support)
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Add Global Error Handling
$ErrorActionPreference = "Stop"
trap {
    [System.Windows.Forms.MessageBox]::Show("Error: $($_.Exception.Message)`nTrace: $($_.ScriptStackTrace)", "Critical Error", "OK", "Error")
    exit 1
}

# Global variables
$script:Language = "FR"
$script:CompanyName = "SUN DATA CONSULTING"
$script:RepoUrl = "https://github.com/ulrich-sun/stack_sundataconsulting.git"
$script:LocalStackPath = "C:\vagrant-stacks\stack_sundataconsulting"
$script:VagrantExe = "vagrant.exe"
$script:GitExe = "git.exe"

# Company Logo (Base64 encoded)
$script:CompanyLogoBase64 = "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" 

# Helper fn: Base64 to Image
function ConvertFrom-Base64ToImage {
    param([string]$Base64String)
    try {
        if ([string]::IsNullOrEmpty($Base64String)) { return $null }
        $imageBytes = [Convert]::FromBase64String($Base64String)
        $ms = New-Object IO.MemoryStream($imageBytes, 0, $imageBytes.Length)
        $ms.Write($imageBytes, 0, $imageBytes.Length)
        $image = [System.Drawing.Image]::FromStream($ms, $true)
        return $image
    }
    catch { 
        Write-Warning "Logo load failed: $_"
        return $null 
    }
}

function Create-PlaceholderLogo {
    $bmp = New-Object System.Drawing.Bitmap(100, 100)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.Clear([System.Drawing.Color]::FromArgb(0, 102, 153))
    $font = New-Object System.Drawing.Font("Arial", 20, [System.Drawing.FontStyle]::Bold)
    $brush = [System.Drawing.Brushes]::White
    $g.DrawString("SDC", $font, $brush, 20, 35)
    return $bmp
}

# Translations
$script:Translations = @{
    FR = @{
        Title = "Gestionnaire de Stacks Vagrant - SUN DATA CONSULTING"
        Tagline = "Gestion et Orchestration des Environnements de Développement"
        LangLabel = "Langue:"
        Refresh = "Rafraîchir"
        UpdateRepo = "Mettre à jour les Stacks (GitHub)"
        Status = "Statut:"
        Ready = "Prêt"
        ActionColumn = "Actions"
        NameColumn = "Nom de la Stack"
        StatusColumn = "État"
        PathColumn = "Chemin"
        ActionStart = "Démarrer"
        ActionStop = "Arrêter"
        ActionPause = "Mettre en Pause"
        ActionResume = "Reprendre"
        ActionDestroy = "Supprimer (Destroy)"
        ConfirmDestroy = "Êtes-vous sûr de vouloir supprimer la stack '{0}' ? Toutes les données seront perdues."
        Running = "En cours"
        Stopped = "Arrêté"
        Paused = "En pause"
        NotCreated = "Non créé"
        Unknown = "Inconnu"
        WarningRunning = "Attention: Cette stack est déjà en cours d'exécution."
        ErrorVagrant = "Vagrant n'est pas installé ou détecté."
        ErrorGit = "Git n'est pas installé ou détecté."
        Updating = "Mise à jour du dépôt..."
        Scanning = "Recherche des stacks..."
    }
    EN = @{
        Title = "Vagrant Stack Manager - SUN DATA CONSULTING"
        Tagline = "Development Environment Management & Orchestration"
        LangLabel = "Language:"
        Refresh = "Refresh"
        UpdateRepo = "Update Stacks (GitHub)"
        Status = "Status:"
        Ready = "Ready"
        ActionColumn = "Actions"
        NameColumn = "Stack Name"
        StatusColumn = "State"
        PathColumn = "Path"
        ActionStart = "Start"
        ActionStop = "Stop"
        ActionPause = "Pause"
        ActionResume = "Resume"
        ActionDestroy = "Destroy"
        ConfirmDestroy = "Are you sure you want to destroy stack '{0}'? All data will be lost."
        Running = "Running"
        Stopped = "Stopped"
        Paused = "Paused"
        NotCreated = "Not Created"
        Unknown = "Unknown"
        WarningRunning = "Warning: This stack is already running."
        ErrorVagrant = "Vagrant is not installed or detected."
        ErrorGit = "Git is not installed or detected."
        Updating = "Updating repository..."
        Scanning = "Scanning for stacks..."
    }
}

function Get-Translation {
    param([string]$Key)
    return $script:Translations[$script:Language][$Key]
}

# GUI Setup
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(900, 700)
$form.StartPosition = 'CenterScreen'
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false
$form.Text = Get-Translation 'Title'

# Logo
$logoPictureBox = New-Object System.Windows.Forms.PictureBox
$logoPictureBox.Location = New-Object System.Drawing.Point(20, 15)
$logoPictureBox.Size = New-Object System.Drawing.Size(80, 80)
$logoPictureBox.SizeMode = 'Zoom'

# Try to load real logo, else placeholder
$logoImage = ConvertFrom-Base64ToImage $script:CompanyLogoBase64
if (-not $logoImage) { $logoImage = Create-PlaceholderLogo }
$logoPictureBox.Image = $logoImage

$form.Controls.Add($logoPictureBox)

# Company Label
$companyLabel = New-Object System.Windows.Forms.Label
$companyLabel.Location = New-Object System.Drawing.Point(110, 25)
$companyLabel.Size = New-Object System.Drawing.Size(400, 30)
$companyLabel.Text = $script:CompanyName
$companyLabel.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$companyLabel.ForeColor = [System.Drawing.Color]::FromArgb(0, 102, 153)
$form.Controls.Add($companyLabel)

# Tagline
$taglineLabel = New-Object System.Windows.Forms.Label
$taglineLabel.Location = New-Object System.Drawing.Point(110, 60)
$taglineLabel.Size = New-Object System.Drawing.Size(400, 20)
$taglineLabel.Text = Get-Translation 'Tagline'
$taglineLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Italic)
$taglineLabel.ForeColor = [System.Drawing.Color]::Gray
$form.Controls.Add($taglineLabel)

# Separator
$separator = New-Object System.Windows.Forms.Label
$separator.Location = New-Object System.Drawing.Point(10, 105)
$separator.Size = New-Object System.Drawing.Size(860, 2)
$separator.BorderStyle = 'Fixed3D'
$form.Controls.Add($separator)

# Controls Panel
$controlsPanel = New-Object System.Windows.Forms.Panel
$controlsPanel.Location = New-Object System.Drawing.Point(10, 115)
$controlsPanel.Size = New-Object System.Drawing.Size(860, 40)
$form.Controls.Add($controlsPanel)

# Language
$langLabel = New-Object System.Windows.Forms.Label
$langLabel.Location = New-Object System.Drawing.Point(5, 8)
$langLabel.AutoSize = $true
$langLabel.Text = Get-Translation 'LangLabel'
$controlsPanel.Controls.Add($langLabel)

$langCombo = New-Object System.Windows.Forms.ComboBox
$langCombo.Location = New-Object System.Drawing.Point(60, 5)
$langCombo.Width = 80
$langCombo.DropDownStyle = 'DropDownList'
$langCombo.Items.AddRange(@('Français', 'English'))
$langCombo.SelectedIndex = 0
$controlsPanel.Controls.Add($langCombo)

# Buttons
$updateBtn = New-Object System.Windows.Forms.Button
$updateBtn.Location = New-Object System.Drawing.Point(160, 5)
$updateBtn.Width = 200
$updateBtn.Text = Get-Translation 'UpdateRepo'
$controlsPanel.Controls.Add($updateBtn)

$refreshBtn = New-Object System.Windows.Forms.Button
$refreshBtn.Location = New-Object System.Drawing.Point(370, 5)
$refreshBtn.Width = 100
$refreshBtn.Text = Get-Translation 'Refresh'
$controlsPanel.Controls.Add($refreshBtn)

# Grid
$grid = New-Object System.Windows.Forms.DataGridView
$grid.Location = New-Object System.Drawing.Point(10, 165)
$grid.Size = New-Object System.Drawing.Size(860, 450)
$grid.AllowUserToAddRows = $false
$grid.AllowUserToDeleteRows = $false
$grid.ReadOnly = $true
$grid.SelectionMode = 'FullRowSelect'
$grid.MultiSelect = $false
$grid.RowHeadersVisible = $false
$grid.AutoSizeColumnsMode = 'Fill'
$form.Controls.Add($grid)

# Status Bar
$statusStrip = New-Object System.Windows.Forms.StatusStrip
$statusLabel = New-Object System.Windows.Forms.ToolStripStatusLabel
$statusLabel.Text = Get-Translation 'Ready'
$statusStrip.Items.Add($statusLabel)
$form.Controls.Add($statusStrip)

# Logic Functions

# Default Stack Icon (Base64) - A simple "Server/Stack" icon
$script:DefaultStackIconBase64 = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAOxAAADsQBlSsOGwAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAJwSURBVFiF7ZcxSxxRFIW/N7uGRQhIEUuTREgQREhgIVhYiY2d/oO0Fv+FhWChnZ1gIVhYiIWFnYUgIogQ0MaXzIq7M/e8Rey67My66655A8PMvDfv3HPPvDczS0R4z2t2gS3gA/DEa/wCDoAjoO41fK8WcAvYBe4s2Q1wA1wAlVqAWeA18N6SfwEvgL9VATPAC+DRkn8Cj4C/VQA3wB3gyZJ/ATfARSUAs8AbS/oZ8M6SL7qAAl4D95b8G3gNnBcBFPAceGfJv4HnwOm8gAKeAg+W/DN4CpzMCyjgIfBgyb+Bh8DxrIAC7gP3lvwbuA8czwoo4C5wb8m/grvA0ayAAu4Ad5b8G7gDHBa10QJ2gdt+k6fADeCwCKCAb8C9Jf8GvgEHswIK+AzcW/Kv4DNwMCug8gH6UvJv5QOMZgUU8BH4YMm/gI/AwUepjT5gC/jS9wFbwKf/AijgI/DFkn8BH4H9WQEf8hG4teTfykc4mBXwIR+BW0v+rXyEg1kBH/IRuLXk38pH+D8roID3wG1L/g28B/azAgr4ANy05N/AB2A/K6CAD8BNS/4NfAD2ZwUU8Am4acm/gU/A/qyAAj4DNy35N/AZ2J8VUMAX4IYl/wa+APuzAgr4Cly35N/AV2BvVkABX4Frlvwb+ArszQoo4BtwzZJ/A9+AvVkBBXwHrlnyb+A7sDcroIBvwFVL/g18A3ZmBRTwA7hiyT+A78DOrMCy/wA+WdK34AewMyuw7D+Az5b0HfgB7MwKZPkP4LMlfQd+ADuzAsv+A/hiSd+BH8DO9C+0gG/AFUv+DXwDdmYFfsz3vGYX2P4B851tX31D6yEAAAAASUVORK5CYII="

function Get-StackLogo {
    param($StackPath)
    
    # Check for common logo filenames
    $extensions = @(".png", ".jpg", ".jpeg", ".ico")
    $names = @("logo", "icon", "stack")
    
    foreach ($name in $names) {
        foreach ($ext in $extensions) {
            $path = Join-Path $StackPath "$name$ext"
            if (Test-Path $path) {
                try {
                    $img = [System.Drawing.Image]::FromFile($path)
                    # Resize to thumbnail (32x32) for grid
                    $thumb = New-Object System.Drawing.Bitmap(32, 32)
                    $g = [System.Drawing.Graphics]::FromImage($thumb)
                    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
                    $g.DrawImage($img, 0, 0, 32, 32)
                    return $thumb
                } catch {
                    # Ignore invalid image, fallback
                }
            }
        }
    }
    
    # Fallback to default icon
    return ConvertFrom-Base64ToImage $script:DefaultStackIconBase64
}

function Update-Language {
    if ($langCombo.SelectedIndex -eq 1) { $script:Language = "EN" } else { $script:Language = "FR" }
    $form.Text = Get-Translation 'Title'
    $taglineLabel.Text = Get-Translation 'Tagline'
    $langLabel.Text = Get-Translation 'LangLabel'
    $updateBtn.Text = Get-Translation 'UpdateRepo'
    $refreshBtn.Text = Get-Translation 'Refresh'
    $statusLabel.Text = Get-Translation 'Ready'
    
    # Update Grid Headers (Skip Image Column at index 0)
    if ($grid.Columns.Count -gt 0) {
        # Column 0 is Image
        $grid.Columns[1].HeaderText = Get-Translation 'NameColumn'
        $grid.Columns[2].HeaderText = Get-Translation 'StatusColumn'
        $grid.Columns[3].HeaderText = Get-Translation 'PathColumn'
        $grid.Columns[4].HeaderText = Get-Translation 'ActionColumn'
    }
}

$langCombo.Add_SelectedIndexChanged({ Update-Language })

function Initialize-Grid {
    $grid.Columns.Clear()
    
    # 0. Image Column
    $imgCol = New-Object System.Windows.Forms.DataGridViewImageColumn
    $imgCol.HeaderText = ""
    $imgCol.Width = 40
    $imgCol.ImageLayout = 'Zoom'
    $grid.Columns.Add($imgCol) | Out-Null

    # 1. Name
    $grid.Columns.Add("Name", (Get-Translation 'NameColumn')) | Out-Null
    
    # 2. Status
    $colStatus = $grid.Columns.Add("Status", (Get-Translation 'StatusColumn'))
    
    # 3. Path
    $grid.Columns.Add("Path", (Get-Translation 'PathColumn')) | Out-Null
    
    # 4. Action Button
    $btnCol = New-Object System.Windows.Forms.DataGridViewButtonColumn
    $btnCol.HeaderText = (Get-Translation 'ActionColumn')
    $btnCol.Text = "Manage"
    $btnCol.UseColumnTextForButtonValue = $true
    $grid.Columns.Add($btnCol) | Out-Null
    
    # Context Menu for Actions using System.Windows.Forms.ContextMenuStrip (compatible with DataGridView)
    $script:contextMenu = New-Object System.Windows.Forms.ContextMenuStrip
    
    $itemStart = $script:contextMenu.Items.Add('Start')
    $itemPause = $script:contextMenu.Items.Add('Pause')
    $itemResume = $script:contextMenu.Items.Add('Resume')
    $itemStop = $script:contextMenu.Items.Add('Stop')
    $script:contextMenu.Items.Add('-') | Out-Null
    $itemDestroy = $script:contextMenu.Items.Add('Destroy')
    
    $itemStart.Add_Click({ Execute-VagrantAction "up" })
    $itemPause.Add_Click({ Execute-VagrantAction "suspend" })
    $itemResume.Add_Click({ Execute-VagrantAction "resume" })
    $itemStop.Add_Click({ Execute-VagrantAction "halt" })
    $itemDestroy.Add_Click({ Execute-VagrantAction "destroy" })
}

function Update-Repo {
    $statusLabel.Text = Get-Translation 'Updating'
    $form.Refresh()
    
    try {
        if (-not (Test-Path $script:LocalStackPath)) {
            # Clone
            New-Item -ItemType Directory -Path (Split-Path $script:LocalStackPath) -Force | Out-Null
            Start-Process git -ArgumentList "clone $script:RepoUrl `"$script:LocalStackPath`"" -Wait -NoNewWindow
        } else {
            # Pull
            Push-Location $script:LocalStackPath
            Start-Process git -ArgumentList "pull" -Wait -NoNewWindow
            Pop-Location
        }
        $statusLabel.Text = "Update complete."
    } catch {
        $statusLabel.Text = "Update failed: $_"
        [System.Windows.Forms.MessageBox]::Show("Update failed: $_", "Error", "OK", "Error")
    }
    
    Refresh-Stacks
    $statusLabel.Text = Get-Translation 'Ready'
}

$updateBtn.Add_Click({ Update-Repo })

function Get-VagrantStatus {
    param($Path)
    Push-Location $Path
    try {
        $output = vagrant status --machine-readable 2>&1
        # Simple parsing logic
        if ($output -match ",state,running") { return "running" }
        if ($output -match ",state,poweroff") { return "poweroff" }
        if ($output -match ",state,saved") { return "saved" }
        if ($output -match ",state,not_created") { return "not_created" }
        return "unknown"
    } catch { return "error" }
    finally { Pop-Location }
}

function Refresh-Stacks {
    $statusLabel.Text = Get-Translation 'Scanning'
    $form.Refresh()
    $grid.Rows.Clear()
    
    if (Test-Path $script:LocalStackPath) {
        $vagrantFiles = Get-ChildItem -Path $script:LocalStackPath -Filter "Vagrantfile" -Recurse
        
        foreach ($file in $vagrantFiles) {
            $dir = $file.DirectoryName
            $name = $file.Directory.Name
            
            # Get Logo
            $stackLogo = Get-StackLogo $dir
            
            # Get Status (This can be slow, ideally async)
            $statusRaw = Get-VagrantStatus $dir
            
            $statusDisplay = Get-Translation 'Unknown'
            $color = [System.Drawing.Color]::Gray
            
            switch ($statusRaw) {
                "running" { $statusDisplay = Get-Translation 'Running'; $color = [System.Drawing.Color]::Green }
                "poweroff" { $statusDisplay = Get-Translation 'Stopped'; $color = [System.Drawing.Color]::Red }
                "saved" { $statusDisplay = Get-Translation 'Paused'; $color = [System.Drawing.Color]::Orange }
                "not_created" { $statusDisplay = Get-Translation 'NotCreated'; $color = [System.Drawing.Color]::DarkGray }
            }
            
            $rowId = $grid.Rows.Add($stackLogo, $name, $statusDisplay, $dir)
            $grid.Rows[$rowId].Cells[2].Style.ForeColor = $color
            $grid.Rows[$rowId].Tag = @{ Path = $dir; Status = $statusRaw }
            
            # Allow row height adjustment for image if needed
            $grid.Rows[$rowId].Height = 35
        }
    }
    $statusLabel.Text = Get-Translation 'Ready'
}

$refreshBtn.Add_Click({ Refresh-Stacks })

# Handle Grid Clicks
$grid.Add_CellClick({
    param($sender, $e)
    # Button is now at index 4 due to added Image column
    if ($e.RowIndex -ge 0 -and $e.ColumnIndex -eq 4) {
        # Button Clicked - Show Context Menu
        $rect = $grid.GetCellDisplayRectangle($e.ColumnIndex, $e.RowIndex, $false)
        $script:SelectedRowIndex = $e.RowIndex
        $point = $grid.PointToScreen($rect.Location)
        $point.Y += $rect.Height
        $script:contextMenu.Show($point)
        
        # Enable/Disable items based on status
        $tag = $grid.Rows[$e.RowIndex].Tag
        $status = $tag.Status
        
        # Reset
        foreach ($item in $script:contextMenu.Items) { $item.Enabled = $true }
        
        if ($status -eq "running") {
            $script:contextMenu.Items[0].Enabled = $false # Start
            $script:contextMenu.Items[2].Enabled = $false # Resume
        } elseif ($status -eq "saved") {
            $script:contextMenu.Items[0].Enabled = $false # Start
            $script:contextMenu.Items[1].Enabled = $false # Pause
            $script:contextMenu.Items[3].Enabled = $false # Stop
        } elseif ($status -eq "poweroff" -or $status -eq "not_created") {
            $script:contextMenu.Items[1].Enabled = $false # Pause
            $script:contextMenu.Items[2].Enabled = $false # Resume
            $script:contextMenu.Items[3].Enabled = $false # Stop
        }
    }
})

function Execute-VagrantAction {
    param($action)
    
    $row = $grid.Rows[$script:SelectedRowIndex]
    $tag = $row.Tag
    $path = $tag.Path
    $name = $row.Cells[1].Value # Index 1 is Name
    $status = $tag.Status
    
    # Warnings / Confirmations
    if ($action -eq "up" -and $status -eq "running") {
        [System.Windows.Forms.MessageBox]::Show((Get-Translation 'WarningRunning'), "Warning", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        return
    }
    
    if ($action -eq "destroy") {
        $confirm = [System.Windows.Forms.MessageBox]::Show((Get-Translation 'ConfirmDestroy' -f $name), "Confirm Destroy", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)
        if ($confirm -ne 'Yes') { return }
        $cmdArgs = "destroy -f"
    } else {
        $cmdArgs = $action
    }
    
    # Execute
    $statusLabel.Text = "$action stack '$name'..."
    $form.Enabled = $false
    $form.Cursor = [System.Windows.Forms.Cursors]::WaitCursor
    
    Push-Location $path
    
    # Run in background job or just wait (simpler to wait for this mock)
    Start-Process vagrant -ArgumentList $cmdArgs -NoNewWindow -Wait
    
    Pop-Location
    
    # Refresh
    Refresh-Stacks
    $form.Cursor = [System.Windows.Forms.Cursors]::Default
    $form.Enabled = $true
}

# Initial Setup
Initialize-Grid
Update-Language

# Auto-check for repo
if (-not (Test-Path $script:LocalStackPath) -or (Get-ChildItem $script:LocalStackPath).Count -eq 0) {
    $result = [System.Windows.Forms.MessageBox]::Show("Le dépôt des stacks n'est pas présent localement. Voulez-vous le télécharger maintenant ?`n`nThe stack repository is missing locally. Do you want to download it now?", "Download Stacks", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)
    if ($result -eq 'Yes') {
        # Check for Git first
        try {
            $gitVersion = & git --version 2>&1
            if ($LASTEXITCODE -eq 0) {
                Update-Repo
            } else {
                [System.Windows.Forms.MessageBox]::Show("Erreur: Git n'est pas détecté. Veuillez installer Git pour continuer.`n`nError: Git not detected. Please install Git to continue.", "Git Missing", "OK", "Error")
            }
        } catch {
             [System.Windows.Forms.MessageBox]::Show("Erreur critique: Impossible d'exécuter Git.`n`nCritical Error: Unable to execute Git.", "Git Missing", "OK", "Error")
        }
    }
} else {
    Refresh-Stacks
}

# Show Form
[void]$form.ShowDialog()

