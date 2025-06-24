# ClaudeFlow + Coder Starter

Minimal starter template integrating [Coder](https://github.com/coder/coder) (self-hosted cloud development) with [claude-flow](https://github.com/ruvnet/claude-code-flow) (AI multi-agent orchestration) and [claude-code](https://www.npmjs.com/package/@anthropic-ai/claude-code) CLI.

## 🤔 Why Use These Together?

- **Consistent Environments**: Reproducible workspaces with AI assistance
- **Multi-Agent AI**: Coordinate up to 5 AI agents for complex tasks
- **Complete Dev Stack**: 30+ pre-installed TypeScript/JavaScript tools
- **Quick Setup**: One-command deployment with Docker Compose

> **💡 Note**: Claude Code CLI requires Claude Max subscription ($20/month)

## 🚀 Quick Start

### Use as Template

```bash
# GitHub UI: Click "Use this template" → "Create new repository"
# Or via CLI:
gh repo create my-project --template iaminawe/claudeflow-coder-starter

# Clone and initialize
git clone https://github.com/your-username/my-project
cd my-project
./scripts/init-project.sh  # Customizes project + runs claude-flow init --sparc
```

### Direct Setup

```bash
# Clone and deploy
git clone https://github.com/iaminawe/claudeflow-coder-starter
cd claudeflow-coder-starter
docker compose up -d

# Access Coder UI at http://localhost:7080
```

## ✨ Features

### AI Development
- **claude-code CLI**: Direct Claude AI assistance (requires subscription)
- **claude-flow**: Open-source multi-agent orchestration with SPARC framework
- **Convenient Aliases**: `c`, `cf`, `swarm`, `claude go`, `claude continue`

### Development Tools
- **Languages**: TypeScript, Node.js 20, Python 3
- **Build Tools**: Vite, Webpack, ESBuild, Rollup, Parcel
- **Testing**: Jest, Vitest, Playwright, Cypress
- **Frameworks**: React, Next.js, Vue, Angular, Svelte CLIs
- **Code Quality**: ESLint, Prettier, TypeScript ESLint
- **VS Code**: 15+ extensions pre-configured

### Infrastructure
- **Coder Workspaces**: Browser-based VS Code environments
- **DevContainers**: VS Code DevContainer support
- **Docker Compose**: Local Coder server deployment
- **Terraform Templates**: Customizable workspace configurations

## 📋 Prerequisites

```bash
# Install Docker
curl -fsSL https://get.docker.com | sh

# Install Claude Code CLI (requires Claude Max subscription)
npm install -g @anthropic-ai/claude-code
claude auth login  # Browser authentication required

# Install Coder CLI
curl -fsSL https://coder.com/install.sh | sh
```

## 💻 Usage

### Workspace Commands

```bash
# Create workspace from template
coder templates create claude-flow template/
coder create my-workspace --template=claude-flow

# Access workspace
coder ssh my-workspace
coder port-forward my-workspace --tcp 3000:3000
```

### AI Commands

```bash
# Claude Code (Anthropic's CLI)
claude "analyze my codebase"
c "debug this function"              # short alias
claude go "review files"             # bypass permissions
claude continue "implement the fix"  # continue + bypass

# claude-flow (multi-agent orchestration)
cf architect "design microservice"
swarm "build REST API with tests"   # parallel agents
```

### Example Workflow

```bash
# Complex task with multiple agents
swarm "Create e-commerce cart with:
- React components
- API endpoints
- Database schema
- Unit tests
- Documentation"

# Combined AI tools
c "find bugs" && cf security "fix vulnerabilities"
```

## 📚 Documentation

- [Getting Started](docs/getting-started.md) - Detailed setup guide
- [Templates](docs/templates.md) - Customize Coder workspaces
- [Pre-installed Packages](docs/pre-installed-packages.md) - Complete tool list
- [Troubleshooting](docs/troubleshooting.md) - Common issues

### Key Folders
- `.coder/` - Advanced Coder configuration and deployment guides
- `.devcontainer/` - VS Code DevContainer configuration
- `template/` - Coder workspace Terraform template
- `scripts/` - Setup and initialization scripts

## 🤝 Contributing

Issues and PRs welcome! Please star ⭐ if you find this useful.

## 📝 License

MIT License - see [LICENSE](LICENSE) file.