# Pre-installed Packages

## AI Development Tools

| Package | Purpose | Global Install |
|---------|---------|----------------|
| `@anthropic-ai/claude-code` | Anthropic's official Claude CLI | ✅ Yes |
| `@ruvnet/claude-flow` | Multi-agent orchestration library | ✅ Yes |

## TypeScript/JavaScript Development Stack

### Core Language Tools
| Package | Purpose | Global Install |
|---------|---------|----------------|
| `typescript` | TypeScript compiler | ✅ Yes |
| `ts-node` | TypeScript execution engine | ✅ Yes |
| `tsx` | TypeScript execute engine (fast) | ✅ Yes |

### Package Managers
| Package | Purpose | Global Install |
|---------|---------|----------------|
| `yarn` | Fast, reliable package manager | ✅ Yes |
| `pnpm` | Efficient package manager | ✅ Yes |

### Build Tools & Bundlers
| Package | Purpose | Global Install |
|---------|---------|----------------|
| `vite` | Fast build tool for modern web projects | ✅ Yes |
| `webpack` | Module bundler | ✅ Yes |
| `webpack-cli` | Webpack command line interface | ✅ Yes |
| `esbuild` | Extremely fast JavaScript bundler | ✅ Yes |
| `rollup` | Module bundler for libraries | ✅ Yes |
| `parcel` | Zero-config build tool | ✅ Yes |

### Development Servers & Tools
| Package | Purpose | Global Install |
|---------|---------|----------------|
| `nodemon` | Auto-restart development server | ✅ Yes |
| `concurrently` | Run multiple commands concurrently | ✅ Yes |
| `pm2` | Production process manager | ✅ Yes |
| `serve` | Static file serving | ✅ Yes |
| `http-server` | Simple HTTP server | ✅ Yes |

### Testing Frameworks
| Package | Purpose | Global Install |
|---------|---------|----------------|
| `jest` | JavaScript testing framework | ✅ Yes |
| `vitest` | Vite-native testing framework | ✅ Yes |
| `playwright` | End-to-end testing | ✅ Yes |
| `cypress` | End-to-end testing platform | ✅ Yes |

### Code Quality Tools
| Package | Purpose | Global Install |
|---------|---------|----------------|
| `eslint` | JavaScript/TypeScript linter | ✅ Yes |
| `prettier` | Code formatter | ✅ Yes |
| `@typescript-eslint/parser` | TypeScript parser for ESLint | ✅ Yes |
| `@typescript-eslint/eslint-plugin` | TypeScript ESLint rules | ✅ Yes |

### Framework CLIs
| Package | Purpose | Global Install |
|---------|---------|----------------|
| `create-react-app` | React application generator | ✅ Yes |
| `create-next-app` | Next.js application generator | ✅ Yes |
| `@vue/cli` | Vue.js CLI | ✅ Yes |
| `@angular/cli` | Angular CLI | ✅ Yes |
| `create-svelte` | SvelteKit application generator | ✅ Yes |
| `@nestjs/cli` | NestJS CLI | ✅ Yes |

### Utilities
| Package | Purpose | Global Install |
|---------|---------|----------------|
| `json-server` | Mock REST API server | ✅ Yes |
| `dotenv-cli` | Load environment variables | ✅ Yes |
| `rimraf` | Cross-platform rm -rf | ✅ Yes |
| `cross-env` | Cross-platform environment variables | ✅ Yes |
| `husky` | Git hooks | ✅ Yes |
| `lint-staged` | Run linters on staged files | ✅ Yes |

## Deployment Options

### 🎯 **Coder Workspaces** (Primary - `template/build/Dockerfile`)
Self-hosted cloud development environments:
- ✅ Complete TypeScript/JavaScript development stack (30+ packages)
- ✅ AI tools: `@anthropic-ai/claude-code` and `@ruvnet/claude-flow`
- ✅ All convenience aliases (`claude go`, `claude continue`, etc.)
- ✅ VS Code Server with 15+ pre-installed extensions
- ✅ Configurable resources (CPU, memory, storage)

### 🏗️ **Advanced Coder Environment** (`.coder/Dockerfile`)
Enterprise-grade development platform:
- ✅ Everything from template container
- ✅ Enhanced development stack (35+ packages)
- ✅ Oh My Zsh with productivity plugins
- ✅ Docker CLI and advanced tooling
- ✅ Health monitoring and workspace management

### 📦 **VS Code DevContainers** (`.devcontainer/Dockerfile`)
VS Code integrated development:
- ✅ AI tools and core development stack (25+ packages)
- ✅ All convenience aliases (bash + zsh support)
- ✅ Microsoft DevContainer base image
- ✅ Seamless VS Code integration

## Available Commands

After container startup, these commands are immediately available:

```bash
# AI Development Tools
claude --version
claude "analyze my code"
c "debug this function"              # short alias
claude go "review restricted files"  # bypass permissions
claude continue "implement the fix"  # continue + bypass permissions
claude-flow --version
cf --help                           # alias
cf-swarm "build a React app"        # parallel execution

# TypeScript/JavaScript Development
tsc --version                       # TypeScript compiler
ts-node script.ts                   # Execute TypeScript directly
tsx script.ts                       # Fast TypeScript execution

# Package Managers
npm --version
yarn --version
pnpm --version

# Build Tools
vite --version
webpack --version
esbuild --version

# Development Servers
nodemon app.js                      # Auto-restart server
serve dist/                         # Serve static files
http-server public/                 # Simple HTTP server

# Testing
jest --version
vitest --version
playwright --version
cypress --version

# Code Quality
eslint --version
prettier --version

# Framework CLIs
create-react-app my-app
create-next-app my-next-app
vue create my-vue-app
ng new my-angular-app
npm create svelte@latest my-svelte-app
nest new my-nest-app

# Utilities
json-server db.json                 # Mock REST API
dotenv-cli -e .env -- npm start    # Load environment variables
rimraf dist/                        # Cross-platform rm -rf
```

## Installation Verification

Check if packages are properly installed:

```bash
# Check installations
which claude
which claude-flow
npm list -g @anthropic-ai/claude-code
npm list -g @ruvnet/claude-flow

# Test aliases
type claude
type c
alias | grep -E "(claude|cf)"
```

## Troubleshooting

If packages are missing:

1. **Check container build logs** for npm install errors
2. **Verify user permissions** for global npm packages
3. **Manually reinstall** if needed:
   ```bash
   npm install -g @anthropic-ai/claude-code @ruvnet/claude-flow
   ```

All containers should have these packages pre-installed. Missing packages indicate a build issue that should be resolved by rebuilding the container.