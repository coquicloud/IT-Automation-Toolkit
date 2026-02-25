# Contributing to IT Automation Toolkit

Thank you for investing your time in contributing to our project! We welcome contributions from DevOps Engineers, System Architects, and SysAdmins looking to modernize automation correctly.

Please review the following guidelines before you start working on contributions.

## Important Note

**Do not commit directly to the `main` branch.** All changes must be made via Pull Requests from a feature/bugfix branch.

## Branching Strategy

We use a feature-branch workflow. Follow this naming convention for your branches:

* **Feature Branches**: `feat/<brief-description>` (e.g., `feat/add-pester-tests`)
* **Bugfix Branches**: `fix/<brief-description>` (e.g., `fix/ad-script-typo`)
* **Documentation Branches**: `docs/<brief-description>` (e.g., `docs/update-readme`)
* **Refactoring Branches**: `refactor/<brief-description>` (e.g., `refactor/modularize-ad-tools`)

## Commits

Write clear and descriptive commit messages. We follow Conventional Commits guidelines:

* `feat: add CI/CD pipeline for PowerShell`
* `fix: resolve hardcoded path in BitLocker script`
* `docs: update API endpoints for User UI`
* `style: format code according to PSScriptAnalyzer`
* `test: add unit tests for user lookup`

## How to Contribute

1. **Fork the repository** (if you don't have direct push access) or clone it locally.
2. **Create a branch** using the naming strategy mentioned above off of the latest `main` branch.
3. **Make your changes**. Adhere to the coding standards below.
4. **Test your changes**. Run any available tests (e.g., Pester) locally to ensure nothing is broken.
5. **Commit and Push** your changes to your branch.
6. **Open a Pull Request (PR)** against the `main` branch.

## Pull Request Guidelines

1. Keep PRs focused. Do not mix unrelated changes in a single PR (e.g., don't add a new firewall script and fix an Active Directory bug in the same PR).
2. Provide a clear description of *why* the change is being made and *how* you implemented it.
3. Link to any relevant issue numbers if applicable.
4. If the change affects users, ensure documentation (like `README.md`) is updated.
5. Wait for review. Your PR must be reviewed and approved by at least one other team member before being merged.

## Coding Standards

### PowerShell

* **Use Verb-Noun naming convention** for all functions (e.g., `Get-StaleMachine`, `Invoke-SystemAudit`).
* **Avoid aliases** in scripts (use `Get-ChildItem` instead of `ls` or `dir`, use `Where-Object` instead of `?`).
* **Implement Error Handling**: Use `try/catch` blocks and define `$ErrorActionPreference = 'Stop'` at the top of scripts when appropriate. Stop relying entirely on `Write-Error`.
* **Parameterize everything**: Never hardcode paths, API keys, or domain names in the script. Use parameterized scripts (`param(...)`).
* **Linting**: Ensure scripts pass `PSScriptAnalyzer` without warnings.

### Infrastructure as Code (Terraform)

* Format code automatically using `terraform fmt` before committing.
* Validate configurations using `terraform validate`.
* Keep modules dry. Do not copy-paste large blocks of infrastructure definitions.

### General DevOps Principles

* **Idempotency is King**: Code should be runnable multiple times without causing errors or changing the state if the desired state is already met. (e.g., Don't just `New-ADUser`; check if the user exists first, and update them, or gracefully skip).
* **Automate Everything**: If you have to do it manually more than twice, script it. If you have to run a script more than twice manually, put it in a pipeline or a scheduled job.

Thank you for contributing!
