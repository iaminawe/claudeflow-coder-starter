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
  username = data.coder_workspace.me.owner
}

data "coder_provisioner" "me" {}
data "coder_workspace" "me" {}

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
  arch                   = data.coder_provisioner.me.arch
  os                     = "linux"
  startup_script_timeout = 180
  startup_script = <<-EOT
    set -e

    # Clone repository if provided
    if [ -n "${data.coder_parameter.git_repo.value}" ]; then
      git clone "${data.coder_parameter.git_repo.value}" ~/project
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

    # Initialize claude-flow with SPARC (if not already done)
    if [ ! -f ~/.claude-flow/config.json ]; then
      claude-flow init --sparc
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
    echo "Available commands after authentication:"
    echo "  claude        - Anthropic Claude Code CLI"
    echo "  c             - claude (short alias)"
    echo "  claude go     - claude --dangerously-skip-permissions"
    echo "  claude continue - claude --continue --dangerously-skip-permissions"
    echo "  cf            - claude-flow (open source)"
    echo "  swarm         - claude-flow swarm --parallel"
    echo ""
    echo "💡 Examples:"
    echo "  claude go 'analyze my code'     (bypass permissions)"
    echo "  claude continue 'fix the bug'   (continue + bypass permissions)"
    echo "================================================="
  EOT

  # These environment variables allow you to make Git commits right away after creating a
  # workspace. Note that they take precedence over configuration defined in ~/.gitconfig!
  # You can remove this block if you'd prefer to configure Git manually or using
  # dotfiles. (see docs/dotfiles.md)
  env = {
    GIT_AUTHOR_NAME     = coalesce(data.coder_workspace.me.owner_name, data.coder_workspace.me.owner)
    GIT_AUTHOR_EMAIL    = "${data.coder_workspace.me.owner_email}"
    GIT_COMMITTER_NAME  = coalesce(data.coder_workspace.me.owner_name, data.coder_workspace.me.owner)
    GIT_COMMITTER_EMAIL = "${data.coder_workspace.me.owner_email}"
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
  name = "coder-${data.coder_workspace.me.owner}-${lower(data.coder_workspace.me.name)}"
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
    value = data.coder_workspace.me.owner
  }
  labels {
    label = "coder.owner_id"
    value = data.coder_workspace.me.owner_id
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
    value = data.coder_workspace.me.owner
  }
  labels {
    label = "coder.owner_id"
    value = data.coder_workspace.me.owner_id
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