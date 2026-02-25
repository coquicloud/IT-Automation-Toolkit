# Target Architecture: IT Automation Platform

This document describes the target architecture of the IT Automation Toolkit, transitioning from local scripts to a cloud-native, self-service platform.

The diagrams below are modeled using the [C4 Model for Visualising Software Architecture](https://c4model.com/).

## 1. System Context Diagram

*This diagram shows the big picture of the system, the users who interact with it, and the external systems it depends on.*

```mermaid
C4Context
  title System Context diagram for IT Automation Platform

  Person(helpdesk, "Helpdesk Technician", "A user in the Helpdesk AD group who needs to execute secure tasks without Domain Admin rights.")
  Person(sysadmin, "System Administrator", "A senior engineer who authors scripts, manages infrastructure, and configures the platform.")

  System(platform, "IT Automation Platform", "Provides a secure, audited web interface to execute administrative actions across the network.")

  System_Ext(ad, "Active Directory (Entra ID / On-Prem)", "Stores user accounts, groups, and permissions. Serves as the Identity Provider.")
  System_Ext(target_machines, "Target Workstations / Servers", "The machines where scripts (e.g., driver backups, BitLocker audits) are executed.")
  System_Ext(github, "GitHub", "Stores the source code, runs CI/CD pipelines, and manages the Terraform/Ansible configurations.")

  Rel(helpdesk, platform, "Triggers automation tasks, views reports", "HTTPS")
  Rel(sysadmin, platform, "Configures settings, views audit logs", "HTTPS")
  Rel(sysadmin, github, "Commits code, reviews PRs", "Git")
  
  Rel(platform, ad, "Authenticates users, queries directory data, resets passwords", "LDAP / MS Graph API")
  Rel(platform, target_machines, "Executes PowerShell scripts, Ansible playbooks", "WinRM / SSH")
  Rel(github, platform, "Deploys updates via CI/CD", "HTTPS")

  UpdateElementStyle(platform, $fontColor="white", $bgColor="#1168bd", $borderColor="#0b4884")
```

---

## 2. Container Diagram

*This diagram zooms in to the `IT Automation Platform` to show the distinct applications and data stores that make up the system.*

```mermaid
C4Container
  title Container diagram for IT Automation Platform

  Person(helpdesk, "Helpdesk Technician", "Executes tasks.")
  
  System_Ext(ad, "Identity Provider (Entra ID)", "OAuth/OIDC Authentication")
  System_Ext(target_machines, "Target Machines", "Windows Endpoints")

  System_Boundary(c1, "IT Automation Platform Environment") {
    
    Container(spa, "Single Page Application", "React / Next.js", "Provides the UI dashboard for users to select tasks, view progress, and read logs. Hosted via GitHub Pages or static host.")
    
    Container(api, "Execution API", "Azure Functions / AWS Lambda", "Serverless API. Receives requests from the SPA, validates the JWT, and orchestrates the script execution.")
    
    Container(ps_worker, "PowerShell Worker Container", "Docker / Azure Container Instances", "A secure, ephemeral runtime environment where the actual IT-Automation-Toolkit PowerShell modules are executed.")
    
    ContainerDb(db, "Audit Database", "PostgreSQL / CosmosDB", "Stores a persistent log of every action executed, who executed it, and the stdout/stderr results.")
  }

  Rel(helpdesk, spa, "Selects action (e.g. Reset Password)", "HTTPS")
  Rel(spa, ad, "Authenticates and gets JWT", "HTTPS")
  Rel(spa, api, "Makes API calls with JWT", "JSON/HTTPS")
  
  Rel(api, ad, "Validates token and group membership", "HTTPS")
  Rel(api, db, "Writes audit log (Started)", "TCP")
  Rel(api, ps_worker, "Triggers job execution", "gRPC / AMQP")
  
  Rel(ps_worker, target_machines, "Connects to endpoint to run script", "WinRM")
  Rel(ps_worker, db, "Writes execution results (Success/Fail)", "TCP")

  UpdateElementStyle(spa, $fontColor="white", $bgColor="#438dd5", $borderColor="#2e6295")
  UpdateElementStyle(api, $fontColor="white", $bgColor="#438dd5", $borderColor="#2e6295")
  UpdateElementStyle(ps_worker, $fontColor="white", $bgColor="#438dd5", $borderColor="#2e6295")
  UpdateElementStyle(db, $fontColor="white", $bgColor="#f4a261", $borderColor="#e76f51")
```

## How This Works (The Flow)

1. The **Helpdesk Technician** goes to the internal website (SPA).
2. They log in with their corporate account via **Active Directory (Entra ID)**.
3. They click "Unlock User".
4. The **SPA** sends an API request to the **Execution API**, attaching their secure login token (JWT).
5. The **Execution API** verifies they are actually in the "Helpdesk" group. If yes, it logs the request in the **Audit Database**.
6. The API sends a message to the **PowerShell Worker Container** to actually run `StaleUserFinder.ps1` or `LocalUserReset.ps1` against the target.
7. The Container executes the raw PowerShell code against the **Target Machine** via WinRM.
8. The result is saved back to the database and returned to the UI.
