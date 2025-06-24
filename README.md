# ClaudeFlow + Coder Starter

Minimal starter template for integrating [claude-flow](https://github.com/ruvnet/claude-code-flow) with [Coder](https://github.com/coder/coder) development environments.

## 🤔 Why Use These Together?

**[Coder](https://github.com/coder/coder)** provides self-hosted cloud development environments while **[claude-flow](https://github.com/ruvnet/claude-code-flow)** adds AI-powered multi-agent orchestration. Additionally, **[claude-code](https://www.npmjs.com/package/@anthropic-ai/claude-code)** gives direct access to Claude AI assistance. This starter template provides everything needed to get started:

> **💡 Note**: This setup includes both free (Coder, claude-flow) and paid (Claude Code CLI requiring Claude Max subscription ~$20/month) components.

### 🌩️ **Cloud + AI Development**
- **Consistent Environments**: Reproducible workspaces across your team
- **AI-Powered Coding**: Multi-agent assistance for complex development tasks
- **Scalable Infrastructure**: Spin up powerful workspaces on-demand
- **Collaborative AI**: Shared AI context and workflows across team members

### 🎯 **Perfect For**
- **Remote Teams**: Standardized development environments with AI assistance
- **Complex Projects**: Multi-agent coordination for large codebases
- **Rapid Prototyping**: Quick workspace setup with AI-powered development
- **Learning & Experimentation**: Safe, isolated environments for trying new ideas
- **Enterprise Development**: Secure, controlled environments with AI enhancement

### 💡 **Real-World Use Cases**
- **API Development**: Use AI agents to generate, test, and document APIs
- **Code Reviews**: AI-assisted analysis in consistent review environments  
- **Architecture Planning**: Multi-agent system design and implementation
- **Documentation**: Automated docs generation in standardized workspaces
- **Debugging**: AI-powered troubleshooting in reproducible environments

## 🚀 Quick Start

### Option 1: Use as Template for New Project

```bash
# Create new repository from this template
gh repo create my-new-project --template your-org/claudeflow-starter --public
cd my-new-project

# Or use GitHub's "Use this template" button in the web interface
# Then clone your new repo:
git clone https://github.com/your-username/my-new-project
cd my-new-project

# Initialize your development environment
./scripts/init-project.sh
```

### Option 2: Clone and Use Directly

```bash
# Clone and setup
git clone https://github.com/your-org/claudeflow-starter
cd claudeflow-starter

# Deploy Coder (requires Docker)
docker compose up -d

# Create workspace
coder create my-workspace --template=claude-flow

# Access workspace
coder ssh my-workspace
```

Access Coder UI: http://localhost:7080

## 📋 Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Usage](#usage)
- [Documentation](#documentation)

## ✨ Features

### 🤖 **AI-Powered Development**
- **SPARC Framework**: 17 specialized AI development modes (Architect, Coder, TDD, Security, etc.)
- **Multi-Agent Orchestration**: Coordinate up to 5 AI agents working in parallel
- **Intelligent Workflows**: AI agents handle complex, multi-step development tasks
- **Shared Memory**: Persistent AI context across workspace sessions

### ☁️ **Cloud Development Infrastructure**  
- **Coder Workspaces**: Self-hosted, reproducible development environments
- **On-Demand Scaling**: Configure CPU, memory, and storage per workspace
- **VS Code Integration**: Full-featured browser-based IDE with extensions
- **DevContainer Support**: VS Code DevContainer compatibility included
- **Docker-in-Docker**: Container development within secure workspaces

### 🔧 **Complete Development Environment**
- **🤖 AI Tools**: `@anthropic-ai/claude-code` and `@ruvnet/claude-flow` pre-installed
- **⚡ TypeScript/JavaScript Stack**: TypeScript, Vite, Jest, ESLint, Prettier, and 30+ dev tools
- **📦 Package Managers**: npm, yarn, pnpm ready to use
- **🏗️ Build Tools**: Vite, Webpack, ESBuild, Rollup, Parcel pre-configured
- **🧪 Testing Frameworks**: Jest, Vitest, Playwright, Cypress included
- **🎨 Framework CLIs**: React, Next.js, Vue, Angular, Svelte, NestJS ready
- **🔧 VS Code Extensions**: 15+ extensions for optimal development experience
- **🚀 One-Click Deploy**: Complete setup with `docker compose up -d`

## 📋 Prerequisites

### Required Software
- **Docker** and **Docker Compose**
- **Claude Max Subscription** (required for claude-code CLI)
- **2GB+ RAM** available for containers
- **Internet connection** for package downloads

### Installation Steps

```bash
# 1. Install Docker (Linux/macOS/WSL2)
curl -fsSL https://get.docker.com | sh

# 2. Install Claude Code CLI (requires Claude Max subscription)
npm install -g @anthropic-ai/claude-code

# 3. Authenticate Claude Code (manual step required)
claude auth login
# Follow the authentication flow in your browser
# This requires an active Claude Max subscription

# 4. Install Coder CLI
curl -fsSL https://coder.com/install.sh | sh
```

### ⚠️ **Important Authentication Note**
The `@anthropic-ai/claude-code` CLI requires:
- An active **Claude Max subscription** ($20/month)
- Manual authentication via `claude auth login`
- Browser-based authentication flow

This is different from the `@ruvnet/claude-flow` library which is a separate open-source project.

## 🚀 Setup

```bash
# 1. Clone repository
git clone https://github.com/your-org/claudeflow-starter
cd claudeflow-starter

# 2. Start Coder server
docker compose up -d

# 3. Create first admin user (open browser to http://localhost:7080)
# Follow setup wizard

# 4. Create workspace template
coder templates create claude-flow template/

# 5. Create your workspace
coder create my-workspace --template=claude-flow
```

## 💻 Usage

### Basic Commands

```bash
# List workspaces
coder list

# SSH into workspace
coder ssh my-workspace

# Port forward
coder port-forward my-workspace --tcp 3000:3000

# Stop/start workspace
coder stop my-workspace
coder start my-workspace
```

### Claude-Flow AI Integration

Once in your workspace, complete authentication and start AI-powered development:

```bash
# STEP 1: Authenticate Claude Code CLI (one-time setup)
claude auth login
# Follow browser authentication flow (requires Claude Max subscription)

# STEP 2: Verify authentication
claude --version

# STEP 3: Use AI development tools
# Claude Code (Anthropic's official CLI)
claude "analyze my codebase for improvements"
c "help me debug this function"    # short alias
claude go "review restricted files"  # bypass permissions
claude continue "implement the fix"  # continue + bypass permissions

# TypeScript/JavaScript development (all tools pre-installed)
create-react-app my-app             # Create React application
npm create next-app@latest my-next  # Create Next.js application
vue create my-vue-app               # Create Vue application
tsc --init                          # Initialize TypeScript project
vite create my-vite-app             # Create Vite project

# claude-flow (open source multi-agent orchestration)
cf --help                           # claude-flow help
swarm "build a REST API"            # parallel agent execution
cf architect "design microservice"  # architecture planning

# Multi-agent development workflows
swarm "create React app with auth, testing, and deployment"
cf tdd "implement user registration with tests"
```

### Example AI Workflows

```bash
# Using Claude Code (Anthropic's official CLI)
claude "review my React component for best practices"
c "explain this complex algorithm"              # short alias
claude "generate unit tests for my API endpoints"

# Permission issues in containers? Use convenient aliases:
claude go "analyze my code"               # bypass permissions
claude continue "fix the previous issue"  # continue conversation

# Using claude-flow (multi-agent orchestration)
swarm "Build e-commerce cart with:
- React frontend components
- Node.js API endpoints  
- Database schema
- Unit tests
- Documentation"

# Combined workflows
c "analyze my architecture" && cf architect "implement improvements"
claude go "find bugs in my code" && cf security "fix security issues"
```

### 🔑 **Two AI Tools, Different Strengths**

- **`claude`/`c`** (Anthropic CLI): Direct interaction with Claude for code analysis, explanations, and assistance
- **`cf/swarm`** (claude-flow): Multi-agent orchestration for complex, parallel development tasks

Both tools work together to provide comprehensive AI-powered development capabilities.

### 🎯 **Convenient Claude Aliases**

Pre-configured aliases make Claude commands easier to use:

```bash
# Standard usage
claude "analyze my code"
c "debug this function"                    # short alias

# Container environments (bypass permissions)  
claude go "analyze my project"             # --dangerously-skip-permissions
claude go "review my codebase"

# Continue conversations (with permission bypass)
claude continue "implement the solution"   # --continue --dangerously-skip-permissions
claude continue "add error handling"

# Combined examples
claude go "find issues" && claude continue "fix them"
```

**Note**: Both `claude go` and `claude continue` include `--dangerously-skip-permissions` since containerized environments often have permission restrictions. Use only in trusted container environments.

### 🛠️ **Manual Alias Setup**

If you want to use these aliases outside of Coder workspaces:

```bash
# Run the setup script
./scripts/setup-claude-aliases.sh

# Or manually add to your shell config (~/.bashrc or ~/.zshrc)
source scripts/setup-claude-aliases.sh
```

## 📚 Documentation

- **[Getting Started](docs/getting-started.md)** - Step-by-step setup guide
- **[Templates](docs/templates.md)** - Workspace template customization
- **[Pre-installed Packages](docs/pre-installed-packages.md)** - AI tools and package details
- **[Troubleshooting](docs/troubleshooting.md)** - Common issues and solutions

### External Links

- [Coder Documentation](https://coder.com/docs) - Official Coder docs
- [claude-flow](https://github.com/ruvnet/claude-code-flow) - AI orchestration library

## 📋 Using as a Template Repository

### GitHub Template Setup

To use this as a template for new projects:

1. **Click "Use this template"** button on GitHub
2. **Create new repository** from template
3. **Clone your new repo** and run initialization:

```bash
git clone https://github.com/your-username/your-new-project
cd your-new-project
./init-project.sh
```

The init script will:
- ✅ Update project name and descriptions
- ✅ Configure Docker container names
- ✅ Set up Git configuration
- ✅ Create initial commit
- ✅ Provide next steps for deployment

### Manual Template Setup

```bash
# Create from template via CLI
gh repo create my-project --template your-org/claudeflow-starter
cd my-project
./init-project.sh

# Follow the prompts to customize your project
```

### What Gets Customized

- **Project name** in `package.json` and `README.md`
- **GitHub usernames** and repository URLs
- **Docker container names** for uniqueness
- **Git configuration** with your details
- **Initial commit** with your project info

## 🤝 Contributing

Contributions welcome! Please open issues and pull requests.

## 📝 License

MIT License - see [LICENSE](LICENSE) file for details.

---

⭐ **Star this repo** if you find it useful!