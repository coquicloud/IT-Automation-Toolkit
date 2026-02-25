# 🚀 Project Backlog: The Journey to a DevOps Platform

This document outlines the roadmap to transform the "IT Automation Toolkit" from a collection of local SysAdmin scripts into a mature, cloud-ready, and automated DevOps platform.

## Phase 1: Foundation & Best Practices (The DevOps Basics)

*Goal: Bring the existing PowerShell scripts up to modern software engineering standards.*

- [ ] **Establish CI/CD Pipelines**
  - Create a `.github/workflows/ci.yml` pipeline.
  - Automate PowerShell linting using `PSScriptAnalyzer`.
  - Enforce branch protection rules (no pushing directly to main).
- [ ] **Implement Automated Testing**
  - Create a `Tests/` directory.
  - Write `Pester` unit tests for critical functions (e.g., AD parsing logic, offline operations).
  - Integrate Pester execution into the GitHub Actions pipeline.
- [ ] **Convert to a PowerShell Module**
  - Refactor standalone `.ps1` scripts into a cohesive `ITAutomationToolkit.psm1` module.
  - Create a module manifest (`.psd1`) outlining versions and dependencies.
  - Remove ALL hardcoded paths; use parameterized variables exclusively.
- [ ] **Centralized Logging & Telemetry**
  - Replace human-readable `Write-Host` with structured logging formats (JSON).
  - Create a generic `Write-Log` function that outputs to standard logging systems (e.g., Windows Event Log, or ships to an ELK stack/Azure Log Analytics).

## Phase 2: Infrastructure as Code (IaC) & Configuration Management

*Goal: Stop manually clicking or running imperative scripts to configure environments.*

- [ ] **Terraform: Infrastructure Provisioning**
  - Create an `Infrastructure/` directory.
  - Write Terraform HCL to provision a "Test Lab" environment (e.g., Azure VMs or AWS EC2 instances running Windows Server).
  - Automate the destruction of the lab to save cloud costs (`terraform destroy`).
- [ ] **Ansible: Configuration Management**
  - Convert `Software-Management` scripts (e.g., Winget installs) into **Ansible Playbooks**.
  - Convert `Security-Audit` lockdown scripts (e.g., disabling USBs) into Ansible tasks or **PowerShell DSC** (Desired State Configuration) to ensure machines *stay* in compliance permanently, rather than relying on point-in-time script execution.

## Phase 3: The Toolkit Web UI (Self-Service Platform)

*Goal: Build a secure, web-based dashboard where Helpdesk or unauthorized users can trigger secure automations without needing Admin rights.*

### ⚠️ Security Architecture Note for the UI
>
> **Can I host this on GitHub Pages?**
> GitHub Pages only hosts *Static* content (HTML/CSS/JS). It cannot execute PowerShell or Batch files.
> To build a UI for these tools, you need a **Backend API**.
> **Is a password safe enough?**
> No. These scripts reset passwords, read BitLocker keys, and modify Domain settings. A simple password on a website is dangerous. You must use Identity-based Authentication (OAuth 2.0 / Entra ID / Auth0).

- [ ] **Frontend (UI)**
  - Build a React or Next.js dashboard. *This frontend CAN be hosted on GitHub pages, Vercel, or Netlify.*
  - Implement a beautiful, dark-mode dashboard (Tailwind CSS or similar) showing categories like "AD Tools", "Network Diagnostics", etc.
- [ ] **Backend API (The Execution Layer)**
  - Build a secure serverless API (e.g., Azure Functions, AWS API Gateway + Lambda, or a simple Node.js Express server).
  - The API receives a request from the UI (e.g., "Reset User X"), authenticates the token, and executes the PowerShell script safely on the backend server.
- [ ] **Identity & Access Management (IAM)**
  - Integrate Microsoft Entra ID (Azure AD) or Auth0 into the frontend.
  - Ensure the API checks the user's JWT token. Only users in the "Helpdesk" or "Admin" Active Directory group should be allowed to trigger the scripts from the UI.

## Phase 4: Containerization & Cloud Native Architecture

*Goal: Run the automation toolkit anywhere, securely.*

- [ ] **Dockerization**
  - Write a `Dockerfile` based on `mcr.microsoft.com/powershell:latest`.
  - Package the `ITAutomationToolkit` module into the container.
  - This allows the automation suite to run on Linux, Mac, or Windows cloud runners without environment mismatches.
- [ ] **Event-Driven Automation**
  - Hook the scripts up to cloud events. (e.g., When an HR system adds a user, trigger an Azure Function to run the AD script automatically without human intervention).

---
*Created as part of the DevOps Portfolio Audit strategy.*
