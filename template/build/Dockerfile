FROM codercom/code-server:latest

USER root

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    python3 \
    python3-pip \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# Python is available via system packages if needed

# Install Claude Code as root before creating user
RUN npm config set registry https://registry.npmjs.org/ && \
    npm cache clean --force && \
    echo "Installing claude-code (primary tool)..." && \
    npm install -g @anthropic-ai/claude-code && \
    echo "claude-flow will be installed on workspace startup..." && \
    echo "Checking claude-code installation..." && \
    npm list -g --depth=0 | grep claude || echo "Claude package check complete"

# Create user with home directory
ARG USER=coder
RUN useradd --groups sudo --create-home --shell /bin/bash ${USER} \
    && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
    && chmod 0440 /etc/sudoers.d/${USER}

USER ${USER}
WORKDIR /home/${USER}

# Install TypeScript/JavaScript development tools as root
USER root
RUN npm install -g \
    # Core language tools
    typescript \
    ts-node \
    tsx \
    # Package managers
    yarn \
    pnpm \
    # Build tools and bundlers
    vite \
    webpack \
    webpack-cli \
    esbuild \
    rollup \
    parcel \
    # Development servers
    nodemon \
    concurrently \
    pm2 \
    # Testing frameworks
    jest \
    vitest \
    playwright \
    cypress \
    # Code quality tools
    eslint \
    prettier \
    @typescript-eslint/parser \
    @typescript-eslint/eslint-plugin \
    # Framework CLIs
    @angular/cli \
    create-react-app \
    @vue/cli \
    create-next-app \
    create-svelte \
    # Utilities
    http-server \
    serve \
    json-server \
    dotenv-cli \
    rimraf \
    cross-env

# Switch back to user for aliases
USER ${USER}

# Set up shell aliases for the user
RUN echo 'alias claude="claude"' >> /home/${USER}/.bashrc \
    && echo 'alias c="claude"' >> /home/${USER}/.bashrc \
    && echo 'alias cf="claude-flow"' >> /home/${USER}/.bashrc \
    && echo 'alias cf-swarm="claude-flow swarm --parallel"' >> /home/${USER}/.bashrc \
    && echo 'claude() { if [ "$1" = "go" ]; then shift; command claude --dangerously-skip-permissions "$@"; elif [ "$1" = "continue" ]; then shift; command claude --continue --dangerously-skip-permissions "$@"; else command claude "$@"; fi; }' >> /home/${USER}/.bashrc \
    && chown ${USER}:${USER} /home/${USER}/.bashrc

# VS Code extensions will be installed on first startup via Coder's built-in mechanism
# This avoids Docker build issues while still providing the same functionality