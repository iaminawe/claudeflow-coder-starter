# Coder Remote Development Setup

This directory contains advanced configuration for using Coder remote development environments.

## What is Coder?

Coder is an open-source platform that provisions secure, high-performance development environments on your infrastructure. It allows you to:

- Create consistent development environments using Terraform templates
- Access your workspace from anywhere via web browser or VS Code
- Scale compute resources based on project needs
- Collaborate with team members in shared environments

## Quick Start with Remote Spaces

### 1. Deploy Coder Server

```bash
# Using Docker Compose (local testing)
docker compose up -d

# Access Coder UI at http://localhost:7080
```

### 2. Create Your First Workspace

1. Open http://localhost:7080 in your browser
2. Complete the initial setup and create an admin user
3. Navigate to Templates → Import the included template
4. Create a new workspace from the template

### 3. Connect to Your Workspace

**Via Web Browser:**
- Click "Open in Browser" from the workspace dashboard
- VS Code will open directly in your browser

**Via VS Code Desktop:**
- Install the Coder extension for VS Code
- Use Command Palette: "Coder: Open Workspace in VS Code"

**Via SSH:**
```bash
# Get SSH connection details from workspace dashboard
ssh coder@your-workspace-url
```

## Template Customization

The included template (`/template/main.tf`) can be customized for your needs:

- **Resource allocation**: Adjust CPU, memory, and disk size
- **Pre-installed tools**: Modify the Dockerfile to include additional software
- **Environment variables**: Add project-specific configuration
- **Git integration**: Configure automatic repository cloning

## Advanced Configuration

### Environment Variables

Set these in your Coder workspace template:

```hcl
resource "coder_env" "claude_config" {
  agent_id = coder_agent.main.id
  name     = "CLAUDE_API_KEY"
  value    = var.claude_api_key
}
```

### Persistent Storage

Configure persistent volumes for project data:

```hcl
resource "docker_volume" "home_volume" {
  name = "coder-${data.coder_workspace.me.id}-home"
}
```

### Team Collaboration

- **Shared templates**: Version control your Terraform templates
- **Resource quotas**: Set limits per user/team
- **RBAC**: Configure role-based access control

## Troubleshooting

### Common Issues

1. **Workspace won't start**: Check Docker daemon and template logs
2. **VS Code connection fails**: Verify port forwarding and firewall settings
3. **Performance issues**: Adjust resource allocation in template

### Useful Commands

```bash
# Check Coder status
coder --help

# List workspaces
coder list

# SSH into workspace
coder ssh <workspace-name>

# Port forward from workspace
coder port-forward <workspace-name> --tcp 3000:3000
```

## Production Deployment

For production use, consider:

- **Infrastructure**: Deploy on Kubernetes, AWS, GCP, or Azure
- **Security**: Configure TLS, authentication, and network policies
- **Monitoring**: Set up logging and metrics collection
- **Backup**: Implement workspace and data backup strategies

Learn more at: https://coder.com/docs