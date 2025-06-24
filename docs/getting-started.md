# Getting Started

## Prerequisites

1. **Claude Max Subscription**
   - Required for `@anthropic-ai/claude-code` CLI
   - $20/month subscription from Anthropic
   - Sign up at https://claude.ai/

2. **Docker and Docker Compose**
   ```bash
   # Install Docker
   curl -fsSL https://get.docker.com | sh
   
   # Verify installation
   docker --version
   docker compose version
   ```

3. **Claude Code CLI**
   ```bash
   # Install Claude Code CLI
   npm install -g @anthropic-ai/claude-code
   
   # Authenticate (requires Claude Max subscription)
   claude auth login
   # Follow browser authentication flow
   
   # Verify authentication
   claude --version
   ```

4. **Coder CLI**
   ```bash
   curl -fsSL https://coder.com/install.sh | sh
   coder --version
   ```

## Setup Steps

### 1. Get the Template

**Option A: Use as GitHub Template (Recommended for new projects)**
```bash
# Use GitHub's "Use this template" button, then:
git clone https://github.com/your-username/your-new-project
cd your-new-project

# Initialize your project
./scripts/init-project.sh
# Follow prompts to customize project name, descriptions, etc.
```

**Option B: Clone Directly (For testing/exploration)**
```bash
git clone https://github.com/your-org/claudeflow-starter
cd claudeflow-starter
```

### 2. Start Coder Server
```bash
docker compose up -d

# Check status
docker compose ps
```

### 3. Initialize Coder
1. Open http://localhost:7080 in your browser
2. Create your first admin user
3. Complete the setup wizard

### 4. Create Template
```bash
coder templates create claude-flow template/
```

### 5. Create Workspace
```bash
# Basic workspace
coder create my-workspace --template=claude-flow

# With custom settings
coder create my-workspace \
  --template=claude-flow \
  --parameter="cpu=4" \
  --parameter="memory=8" \
  --parameter="git_repo=https://github.com/user/repo"
```

### 6. Access Workspace
```bash
# SSH access
coder ssh my-workspace

# VS Code in browser
coder open my-workspace
```

## Pre-installed Development Stack

Your workspace comes with a complete development environment:

### AI Tools
- **`@anthropic-ai/claude-code`** - Anthropic's official Claude CLI
- **`@ruvnet/claude-flow`** - Open-source multi-agent orchestration library

### TypeScript/JavaScript Development
- **Core Tools**: TypeScript, ts-node, tsx
- **Package Managers**: npm, yarn, pnpm
- **Build Tools**: Vite, Webpack, ESBuild, Rollup, Parcel
- **Testing**: Jest, Vitest, Playwright, Cypress
- **Code Quality**: ESLint, Prettier, TypeScript ESLint
- **Framework CLIs**: React, Next.js, Vue, Angular, Svelte, NestJS
- **Development Servers**: Nodemon, http-server, serve
- **Utilities**: JSON Server, dotenv-cli, rimraf, cross-env

### VS Code Extensions (15+)
- TypeScript support, ESLint, Prettier
- Jest testing, Playwright integration
- Auto rename tag, path intellisense
- Live server, CSS peek, HTML/CSS support
- GitHub Copilot, Docker, YAML support

## Using AI Development Tools

Once in your workspace, you'll need to authenticate and can then use both AI tools:

### 1. Authenticate Claude Code CLI
```bash
# One-time authentication (per workspace)
claude auth login
# Follow the browser authentication flow
# Requires active Claude Max subscription

# Verify authentication
claude --version
```

### 2. Use AI Development Tools
```bash
# Claude Code (Anthropic's official CLI)
claude "explain this function"
claude "review my code for bugs"
claude "generate tests for my API"

# claude-flow (multi-agent orchestration)
cf --help
swarm "create a React component with tests"

# Combined workflow
claude "analyze my codebase" && cf architect "suggest improvements"
```

### 3. Pre-configured Aliases
```bash
claude           # Anthropic Claude Code CLI
c                # claude (short alias)
claude go        # claude --dangerously-skip-permissions
claude continue  # claude --continue --dangerously-skip-permissions
cf               # claude-flow
swarm            # claude-flow swarm --parallel
```

### 4. Convenient Claude Aliases

The workspace includes helpful aliases for common Claude operations:

```bash
# Standard usage
claude "analyze my project"
c "review this code"                      # short alias

# Container permission bypass
claude go "analyze my project"            # --dangerously-skip-permissions
claude go "review this code"

# Continue conversations (with permission bypass)
claude continue "implement the fix"       # --continue --dangerously-skip-permissions
claude continue "add tests for this"

# Combined workflows
claude go "find bugs" && claude continue "fix them all"
```

## Quick Start Examples

Create new projects instantly with pre-installed tools:

```bash
# React Application
create-react-app my-react-app
cd my-react-app && npm start

# Next.js Application 
npm create next-app@latest my-next-app
cd my-next-app && npm run dev

# Vue Application
vue create my-vue-app
cd my-vue-app && npm run serve

# TypeScript Project
mkdir my-ts-project && cd my-ts-project
tsc --init
echo 'console.log("Hello TypeScript!");' > index.ts
ts-node index.ts

# Vite Project
npm create vite@latest my-vite-app
cd my-vite-app && npm install && npm run dev

# Test your setup
jest --init                    # Initialize Jest testing
eslint --init                  # Initialize ESLint
prettier --write "**/*.{js,ts,jsx,tsx}"  # Format code
```

## Next Steps

- Read [Templates Guide](templates.md) to customize workspaces
- Check [Pre-installed Packages](pre-installed-packages.md) for complete tool list
- Check [Troubleshooting](troubleshooting.md) for common issues
- Visit [claude-flow docs](https://github.com/ruvnet/claude-code-flow) for AI features