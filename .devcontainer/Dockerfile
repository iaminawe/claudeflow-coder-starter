FROM mcr.microsoft.com/devcontainers/javascript-node:1-20-bullseye

# Install additional system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    python3-pip \
    curl \
    wget \
    git \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Switch to vscode user
USER vscode

# Set up npm global directory for user
RUN mkdir -p ~/.npm-global && \
    npm config set prefix '~/.npm-global' && \
    echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc && \
    echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc && \
    echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.profile

# Install essential global packages (claude-code only, claude-flow will be local)
RUN npm install -g \
    npm@latest \
    @anthropic-ai/claude-code \
    typescript \
    ts-node \
    tsx \
    yarn \
    pnpm \
    vite \
    webpack \
    webpack-cli \
    esbuild \
    nodemon \
    concurrently \
    jest \
    vitest \
    eslint \
    prettier \
    @typescript-eslint/parser \
    @typescript-eslint/eslint-plugin \
    create-react-app \
    create-next-app \
    @vue/cli \
    serve \
    http-server \
    json-server \
    dotenv-cli \
    rimraf \
    cross-env

# Set up Claude aliases for convenient usage
RUN echo 'alias c="claude"' >> ~/.bashrc \
    && echo 'alias cf="claude-flow"' >> ~/.bashrc \
    && echo 'alias cf-swarm="claude-flow swarm --parallel"' >> ~/.bashrc \
    && echo 'claude() { if [ "$1" = "go" ]; then shift; command claude --dangerously-skip-permissions "$@"; elif [ "$1" = "continue" ]; then shift; command claude --continue --dangerously-skip-permissions "$@"; else command claude "$@"; fi; }' >> ~/.bashrc \
    && echo 'alias c="claude"' >> ~/.zshrc \
    && echo 'alias cf="claude-flow"' >> ~/.zshrc \
    && echo 'alias cf-swarm="claude-flow swarm --parallel"' >> ~/.zshrc \
    && echo 'claude() { if [ "$1" = "go" ]; then shift; command claude --dangerously-skip-permissions "$@"; elif [ "$1" = "continue" ]; then shift; command claude --continue --dangerously-skip-permissions "$@"; else command claude "$@"; fi; }' >> ~/.zshrc

# Set PATH environment variable for all processes
ENV PATH="/home/vscode/.npm-global/bin:${PATH}"

WORKDIR /workspaces/claudeflow-starter