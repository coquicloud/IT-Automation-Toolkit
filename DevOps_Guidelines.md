# DevOps & Systems Architecture Guidelines

This document outlines the core technical philosophies, architectural standards, and operational guidelines expected from Systems Architects and DevOps Engineers working on the IT Automation Toolkit.

These represent our "North Star" for all new development and refactoring efforts.

---

## 🏗️ 1. Core Architectural Philosophies

### 1.1 Declarative over Imperative

Whenever possible, define the **ideal state** of a system rather than the *steps* to achieve that state.

* **Bad (Imperative Step-by-Step):** A script that runs `apt-get install nginx`, opens port 80, and copies an HTML file.
* **Good (Declarative State):** A Terraform/Ansible/DSC configuration that states "This server must have Nginx installed, port 80 open, and serve this specific HTML repository."
* *Why?* Declarative systems are inherently **idempotent**, meaning they can be run repeatedly without breaking things if the system is already configured correctly.

### 1.2 "Everything as Code" (EaC)

Manual changes via a GUI ("ClickOps") are technical debt from the moment they are made.

* **Infrastructure as Code (IaC):** Use Terraform or Azure Bicep to provision cloud resources.
* **Configuration as Code (CaC):** Use Ansible, PowerShell DSC, or Chef to configure the OS and software.
* **Pipelines as Code:** Define CI/CD in YAML files (e.g., GitHub Actions) stored alongside the application source code.
* **Documentation as Code:** Maintain architectural diagrams (e.g., Mermaid.js) and `README`s directly in git.

### 1.3 Immutable Infrastructure

Servers should never be patched or updated in place if they can be replaced.

* Changes should always originate from source control.
* If a server configuration changes, destroy the server and deploy a new one built from the updated code template (e.g., using Packer to build a Golden Image).

### 1.4 Principle of Least Privilege

No human, script, or application should have more access than absolutely necessary to perform its job.

* Do not run tasks as Domain Admin if "Helpdesk Reader" is sufficient.
* Service Accounts must have scoped, granular permissions.

---

## 🛠️ 2. Development Standards

### 2.1 The Code Must Be Modular

Monolithic "mega-scripts" are difficult to test and debug.

* Break features down into single-responsibility functions.
* Bundle these functions into modules (e.g., creating a `.psm1` PowerShell module instead of a standalone `.ps1` script).
* Separate the **logic** from the **execution**. A function `Remove-StaleUser` should accept an object; the logic that *finds* those users (`Get-StaleUser`) should be a separate function.

### 2.2 Parameterization

Never hardcode configuration data inside your logic.

* No hardcoded paths (`C:\Users\admin\Desktop\...`)
* No hardcoded URLs (`https://api.company.com/v1/...`)
* No hardcoded credentials (EVER).
* Use Environment Variables, Parameter injection, or secure secret stores (Azure Key Vault, AWS Secrets Manager, HashiCorp Vault).

### 2.3 Automated Testing

Code is a liability until it is proven to work.

* **Unit Tests:** Every individual function or module must have tests (e.g., Pester for PowerShell, PyTest for Python) to verify its logic in isolation without touching actual infrastructure.
* **Integration Tests:** Verify that modules interact correctly with the environment (e.g., Does this script actually create the Test AD user in the sandbox environment?).
* **Linting:** All code must run through a static analyzer (e.g., `PSScriptAnalyzer`, `tflint`) before being merged.

---

## 🚢 3. Delivery & Operations (CI/CD)

### 3.1 Unattended Deployment

A developer should never deploy code from their local laptop to Production.

* All deployments must be handled automatically by a system (GitHub Actions, Jenkins, Azure DevOps, GitLab CI) reacting to a `git push` or `merge` event.
* This ensures the deployment process is documented, repeatable, and audible.

### 3.2 Feature Flags & Blue/Green Deployments

Decouple deployment from release.

* Code can be deployed to production, but hidden behind a toggle (Feature Flag) until it is vetted without affecting real users.
* When deploying massive infrastructure changes, deploy a completely new environment (Green), route traffic to test it, and then switch user traffic over, leaving the old environment (Blue) as a rollback mechanism.

---

## 🔭 4. Observability & Telemetry

### 4.1 Structured Logging

Human-readable logs (e.g., `Write-Host "Started backup at 4 PM"`) are useless at scale.

* Log in a structured format (JSON) that can be easily parsed by systems like Elasticsearch/Logstash/Kibana (ELK), Splunk, Datadog, or Azure Log Analytics.
* Always include metadata: `Timestamp`, `CorrelationID`, `HostName`, `LogLevel`, and the `Message`.

### 4.2 Proactive Monitoring, Not Reactive Alerting

Do not alert when a system goes down (reactive). Alert when leading indicators suggest a system *will* go down (proactive).

* Alert on CPU queues backing up, disk space exhaustion trends, or error rate spikes, not just PING failures.

---
*Signed by the Principal Architects.*
