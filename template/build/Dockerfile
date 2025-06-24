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

# Install AI tools as root before creating user (with debugging)
RUN npm config set registry https://registry.npmjs.org/ && \
    npm cache clean --force && \
    echo "Installing claude-code (primary tool)..." && \
    npm install -g @anthropic-ai/claude-code && \
    echo "Installing claude-flow..." && \
    (npm install -g @ruvnet/claude-flow || echo "claude-flow install failed, continuing...") && \
    echo "Checking installations..." && \
    npm list -g --depth=0 | grep -E "(claude|flow)" || echo "No AI packages found"

# Create user
ARG USER=coder
RUN useradd --groups sudo --no-create-home --shell /bin/bash ${USER} \
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

# Set up shell aliases
RUN echo 'alias claude="claude"' >> ~/.bashrc \
    && echo 'alias c="claude"' >> ~/.bashrc \
    && echo 'alias cf="claude-flow"' >> ~/.bashrc \
    && echo 'alias cf-swarm="claude-flow swarm --parallel"' >> ~/.bashrc \
    && echo 'claude() { if [ "$1" = "go" ]; then shift; command claude --dangerously-skip-permissions "$@"; elif [ "$1" = "continue" ]; then shift; command claude --continue --dangerously-skip-permissions "$@"; else command claude "$@"; fi; }' >> ~/.bashrc

# Pre-install VS Code extensions for TypeScript/JavaScript development
RUN code-server --install-extension ms-vscode.vscode-typescript-next \
    && code-server --install-extension esbenp.prettier-vscode \
    && code-server --install-extension dbaeumer.vscode-eslint \
    && code-server --install-extension bradlc.vscode-tailwindcss \
    && code-server --install-extension ms-python.python \
    && code-server --install-extension ms-vscode.vscode-json \
    && code-server --install-extension formulahendry.auto-rename-tag \
    && code-server --install-extension christian-kohler.path-intellisense \
    && code-server --install-extension ms-vscode.vscode-jest \
    && code-server --install-extension orta.vscode-jest \
    && code-server --install-extension ms-playwright.playwright \
    && code-server --install-extension ms-vscode.vscode-node-azure-pack \
    && code-server --install-extension github.copilot \
    && code-server --install-extension ms-vscode.hexeditor \
    && code-server --install-extension redhat.vscode-yaml \
    && code-server --install-extension ms-vscode.vscode-docker