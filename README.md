# ClaudeFlow + Coder Starter

Minimal starter template integrating [Coder](https://github.com/coder/coder) (self-hosted cloud development) with two AI tools:
- **[claude](https://www.npmjs.com/package/@anthropic-ai/claude-code)** - Anthropic's official Claude CLI for direct AI assistance
- **[claude-flow](https://github.com/ruvnet/claude-code-flow)** - Open-source multi-agent AI orchestration framework

## 🤔 Why Use These Together?

- **Consistent Environments**: Reproducible workspaces with AI assistance
- **Multi-Agent AI**: Coordinate up to 5 AI agents for complex tasks
- **Complete Dev Stack**: 30+ pre-installed TypeScript/JavaScript tools
- **Quick Setup**: One-command deployment with Docker Compose

> **💡 Note**: Claude Code CLI requires Claude Max subscription ($20/month)

## 🚀 Quick Start

### ⚡ Important: Run Initialization Script

**Always run `./scripts/init-project.sh` after cloning!** This script:
- ✅ Customizes the template with your project details
- ✅ Runs `claude-flow init --sparc` to set up AI multi-agent framework
- ✅ Configures Git with your information
- ✅ Creates initial commit
- ✅ Prepares your development environment

### Use as Template

```bash
# GitHub UI: Click "Use this template" → "Create new repository"
# Or via CLI:
gh repo create my-project --template iaminawe/claudeflow-coder-starter

# Clone and initialize (REQUIRED!)
git clone https://github.com/your-username/my-project
cd my-project
./scripts/init-project.sh  # ← Don't skip this step!
```

### Direct Setup (Without Template)

```bash
# Clone and deploy
git clone https://github.com/iaminawe/claudeflow-coder-starter
cd claudeflow-coder-starter

# Run initialization (customizes project and sets up SPARC)
./scripts/init-project.sh  # ← Essential for claude-flow setup!

# Start Coder server
docker compose up -d

# Access Coder UI at http://localhost:7080
```

## ✨ Features

### AI Development Tools (Two Separate Tools)
- **claude (Claude Code CLI)**: Direct Claude AI assistance from Anthropic (requires subscription)
  - Use: `claude "your prompt"` or `c "your prompt"`
  - Special modes: `claude go` and `claude continue` for permission bypass
- **claude-flow**: Open-source multi-agent orchestration with SPARC framework
  - Use: `claude-flow <mode> "prompt"` or `cf <mode> "prompt"`
  - Multi-agent: `swarm "complex task"`

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

### Environment Configuration

The template includes `.env.example` with all available configuration options:

- **Coder Settings**: Server URL, ports, database connection
- **API Keys**: Claude, OpenAI, GitHub tokens (optional)
- **Workspace Resources**: CPU, memory, disk allocations
- **Development Ports**: Vite, Next.js, API server ports

The init script automatically creates `.env` from `.env.example`.

## 💻 Usage

### Workspace Commands

```bash
# IMPORTANT: If you haven't run init-project.sh yet, run it first!
# ./scripts/init-project.sh

# Create workspace from template
coder templates create claude-flow template/
coder create my-workspace --template=claude-flow

# Access workspace
coder ssh my-workspace
coder port-forward my-workspace --tcp 3000:3000
```

### AI Commands

```bash
# Claude Code (Anthropic's CLI) - Direct AI assistance
claude "analyze my codebase"         # Direct Claude interaction
c "debug this function"              # Short alias for 'claude'
claude go "review files"             # Same as: claude --dangerously-skip-permissions
claude continue "implement the fix"  # Same as: claude --continue --dangerously-skip-permissions

# claude-flow (separate tool) - Multi-agent orchestration
claude-flow architect "design microservice"   # Single agent mode
cf architect "design microservice"            # Short alias
swarm "build REST API with tests"            # Multi-agent parallel execution
```

### Example Workflow

```bash
# Direct Claude assistance (single AI)
claude "explain this complex algorithm"
claude "write unit tests for my UserService class"
c "review this React component for best practices"

# Multi-agent orchestration (claude-flow)
claude-flow swarm --parallel "Create e-commerce cart with:
- React components
- API endpoints
- Database schema
- Unit tests
- Documentation"

# Combining both tools
claude "find bugs in my code" && claude-flow security "implement security fixes"
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