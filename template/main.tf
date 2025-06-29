terraform {
  required_providers {
    coder = {
      source = "coder/coder"
    }
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

locals {
  username = data.coder_workspace_owner.me.name
}

data "coder_provisioner" "me" {}
data "coder_workspace" "me" {}
data "coder_workspace_owner" "me" {}

provider "docker" {}

data "coder_parameter" "cpu" {
  name         = "cpu"
  display_name = "CPU"
  description  = "The number of CPU cores"
  default      = "2"
  icon         = "/icon/memory.svg"
  mutable      = true
  option {
    name  = "2 Cores"
    value = "2"
  }
  option {
    name  = "4 Cores"
    value = "4"
  }
  option {
    name  = "6 Cores"
    value = "6"
  }
  option {
    name  = "8 Cores"
    value = "8"
  }
}

data "coder_parameter" "memory" {
  name         = "memory"
  display_name = "Memory"
  description  = "The amount of memory in GB"
  default      = "4"
  icon         = "/icon/memory.svg"
  mutable      = true
  option {
    name  = "4 GB"
    value = "4"
  }
  option {
    name  = "8 GB" 
    value = "8"
  }
  option {
    name  = "16 GB"
    value = "16"
  }
}

data "coder_parameter" "git_repo" {
  name         = "git_repo"
  display_name = "Git Repository"
  description  = "Git repository to clone (optional)"
  default      = ""
  mutable      = true
}

resource "coder_agent" "main" {
  arch = data.coder_provisioner.me.arch
  os   = "linux"
  startup_script = <<-EOT
    set -e

    # Check if this is first run
    FIRST_RUN_FLAG="$HOME/.coder-workspace-initialized"
    IS_FIRST_RUN=false
    
    if [ ! -f "$FIRST_RUN_FLAG" ]; then
      IS_FIRST_RUN=true
      echo "🚀 First workspace startup detected..."
      touch "$FIRST_RUN_FLAG"
    fi

    # Clone repository if provided
    if [ -n "${data.coder_parameter.git_repo.value}" ]; then
      if [ ! -d "~/project" ]; then
        git clone "${data.coder_parameter.git_repo.value}" ~/project
      fi
      cd ~/project
      
      # Install npm dependencies if package.json exists
      if [ -f "package.json" ]; then
        echo "📦 Installing npm dependencies..."
        npm install
      fi
    else
      # If no repo specified, check current directory for package.json
      if [ -f "package.json" ]; then
        echo "📦 Installing npm dependencies..."
        npm install
      fi
    fi

    # Install and initialize claude-flow locally (avoids permission issues)
    if [ ! -f ~/.claude-flow/config.json ]; then
      echo "📦 Installing claude-flow locally in user directory..."
      cd ~
      
      # Create package.json if it doesn't exist
      if [ ! -f package.json ]; then
        npm init -y --quiet > /dev/null 2>&1
      fi
      
      # Install claude-flow as a local dependency
      npm install claude-flow --save-dev
      
      # Add local node_modules/.bin to PATH for this session
      export PATH="$HOME/node_modules/.bin:$PATH"
      
      # Add to .bashrc for future sessions
      if ! grep -q "node_modules/.bin" ~/.bashrc; then
        echo 'export PATH="$HOME/node_modules/.bin:$PATH"' >> ~/.bashrc
      fi
      
      echo "🤖 Initializing claude-flow with SPARC framework..."
      claude-flow init --sparc
    fi

    # Run initialization on first run
    if [ "$IS_FIRST_RUN" = true ]; then
      echo "🔧 Running first-time workspace setup..."
      
      # Create default project structure if no repo provided
      if [ -z "${data.coder_parameter.git_repo.value}" ]; then
        echo "📁 Setting up default project structure..."
        mkdir -p ~/workspace
        cd ~/workspace
        
        # Initialize git if not already done
        if [ ! -d ".git" ]; then
          git init
          git config --global init.defaultBranch main
        fi
        
        # Create basic project files
        echo "# My AI Development Project" > README.md
        echo "node_modules/" > .gitignore
        echo ".env" >> .gitignore
        echo "*.log" >> .gitignore
        
        # Create package.json
        cat > package.json << 'PACKAGE_EOF'
{
  "name": "my-ai-project",
  "version": "1.0.0",
  "description": "AI-powered development project",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "dev": "nodemon index.js",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": ["ai", "claude", "development"],
  "author": "",
  "license": "MIT"
}
PACKAGE_EOF
        
        # Create basic index.js
        cat > index.js << 'JS_EOF'
// Welcome to your AI-powered development environment!
// You have access to both Claude and claude-flow tools.

console.log('🚀 AI Development Environment Ready!');
console.log('');
console.log('Available tools:');
console.log('  claude          - Direct AI assistance (requires auth)');
console.log('  c               - Short alias for claude');
console.log('  claude go       - Claude with permission bypass');
console.log('  claude continue - Continue conversation with bypass');
console.log('  claude-flow     - Multi-agent orchestration');
console.log('  cf              - Short alias for claude-flow');
console.log('  cf-swarm        - Parallel multi-agent execution');
console.log('');
console.log('Get started:');
console.log('  1. Run: claude auth login');
console.log('  2. Try: claude "help me build a web app"');
console.log('  3. Or: cf-swarm "create a full-stack project"');
JS_EOF

        echo "✅ Default project structure created at ~/workspace"
      fi
    fi

    # Display authentication reminder
    echo "================================================="
    echo "⚠️  AUTHENTICATION REQUIRED"
    echo "================================================="
    echo "1. Run: claude auth login"
    echo "2. Complete authentication in browser"
    echo "3. Requires Claude Max subscription"
    echo "================================================="
    echo ""
    echo "Available AI tools (two separate tools):"
    echo ""
    echo "1. Claude (Anthropic's CLI - requires authentication):"
    echo "   claude        - Direct AI assistance"
    echo "   c             - Short alias for 'claude'"
    echo "   claude go     - Bypass permissions (--dangerously-skip-permissions)"
    echo "   claude continue - Continue + bypass permissions"
    echo ""
    echo "2. claude-flow (open-source multi-agent tool):"
    echo "   claude-flow   - Multi-agent orchestration"
    echo "   cf            - Short alias for 'claude-flow'"
    echo "   cf-swarm      - Parallel multi-agent execution"
    echo ""
    echo "💡 Examples:"
    echo "  claude 'explain this function'          # Direct Claude assistance"
    echo "  claude go 'analyze my code'            # Claude with permission bypass"
    echo "  claude-flow architect 'design API'     # Single agent mode"
    echo "  cf-swarm 'build complete feature'      # Multi-agent parallel"
    echo "================================================="
  EOT

  # These environment variables allow you to make Git commits right away after creating a
  # workspace. Note that they take precedence over configuration defined in ~/.gitconfig!
  # You can remove this block if you'd prefer to configure Git manually or using
  # dotfiles. (see docs/dotfiles.md)
  env = {
    GIT_AUTHOR_NAME     = data.coder_workspace_owner.me.name
    GIT_AUTHOR_EMAIL    = "${data.coder_workspace_owner.me.email}"
    GIT_COMMITTER_NAME  = data.coder_workspace_owner.me.name
    GIT_COMMITTER_EMAIL = "${data.coder_workspace_owner.me.email}"
  }
}

resource "coder_app" "code-server" {
  agent_id     = coder_agent.main.id
  slug         = "code-server"
  display_name = "VS Code"
  url          = "http://localhost:8080/?folder=/home/${local.username}"
  icon         = "/icon/code.svg"
  subdomain    = false
  share        = "owner"

  healthcheck {
    url       = "http://localhost:8080/healthz"
    interval  = 5
    threshold = 6
  }
}

resource "docker_image" "main" {
  name = "coder-${data.coder_workspace.me.id}"
  build {
    context = "./build"
    build_args = {
      USER = local.username
    }
  }
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(path.module, "build/*") : filesha1(f)]))
  }
}

resource "docker_container" "workspace" {
  count = data.coder_workspace.me.start_count
  image = docker_image.main.name
  # Uses lower() to avoid Docker restriction on container names.
  name = "coder-${data.coder_workspace_owner.me.name}-${lower(data.coder_workspace.me.name)}"
  # Hostname makes the shell more user friendly: coder@my-workspace:~$
  hostname = data.coder_workspace.me.name
  # Use the docker gateway if the access URL is 127.0.0.1
  entrypoint = ["sh", "-c", replace(coder_agent.main.init_script, "/localhost|127\\.0\\.0\\.1/", "host.docker.internal")]
  env        = ["CODER_AGENT_TOKEN=${coder_agent.main.token}"]
  host {
    host = "host.docker.internal"
    ip   = "host-gateway"
  }
  volumes {
    container_path = "/home/${local.username}"
    volume_name    = docker_volume.home_volume.name
    read_only      = false
  }

  # Add labels in Docker to keep track of orphan resources.
  labels {
    label = "coder.owner"
    value = data.coder_workspace_owner.me.name
  }
  labels {
    label = "coder.owner_id"
    value = data.coder_workspace_owner.me.id
  }
  labels {
    label = "coder.workspace_id"
    value = data.coder_workspace.me.id
  }
  labels {
    label = "coder.workspace_name"
    value = data.coder_workspace.me.name
  }
}

resource "docker_volume" "home_volume" {
  name = "coder-${data.coder_workspace.me.id}-home"
  # Protect the volume from being deleted due to changes in attributes.
  lifecycle {
    ignore_changes = all
  }
  # Add labels in Docker to keep track of orphan resources.
  labels {
    label = "coder.owner"
    value = data.coder_workspace_owner.me.name
  }
  labels {
    label = "coder.owner_id"
    value = data.coder_workspace_owner.me.id
  }
  labels {
    label = "coder.workspace_id"
    value = data.coder_workspace.me.id
  }
  labels {
    label = "coder.workspace_name"
    value = data.coder_workspace.me.name
  }
}

resource "coder_metadata" "container_info" {
  count       = data.coder_workspace.me.start_count
  resource_id = docker_container.workspace[0].id

  item {
    key   = "CPU"
    value = "${data.coder_parameter.cpu.value} cores"
  }
  item {
    key   = "Memory"
    value = "${data.coder_parameter.memory.value}GB"
  }
  item {
    key   = "Image"
    value = "Ubuntu with claude-flow"
  }
}