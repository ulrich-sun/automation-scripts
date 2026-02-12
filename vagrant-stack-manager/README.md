# Vagrant Stack Manager
## SUN DATA CONSULTING

A GUI tool to manage your Vagrant development stacks.

### Features
- **Auto-Discovery:** Automatically finds Vagrant stacks in your repository
- **Status Monitoring:** Shows which stacks are running, stopped, or paused
- **One-Click Actions:** Start, Stop, Pause, Resume, or Destroy stacks
- **Git Integration:** Update your stack definitions directly from GitHub
- **Safety:** Confirmation prompts for destructive actions

### Usage

1. Run `launch-stack-manager.bat` as Administrator
2. Click **"Update Stacks (GitHub)"** to download/update the repository
3. Select a stack from the list
4. Right-click or use the "Manage" button to perform actions:
   - **Start:** Boot up the stack (`vagrant up`)
   - **Pause:** Suspend the VM state (`vagrant suspend`)
   - **Resume:** Resume from paused state (`vagrant resume`)
   - **Stop:** Shut down the VM (`vagrant halt`)
   - **Destroy:** Remove the VM and all data (`vagrant destroy`)

### Configuration

The script clones the repository to:
`C:\vagrant-stacks\stack_sundataconsulting`

To change this, edit `vagrant-stack-manager.ps1`:
```powershell
$script:LocalStackPath = "C:\new\path\..."
```

---
**SUN DATA CONSULTING** - Automation Scripts
