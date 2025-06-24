#!/bin/bash

# ClaudeFlow + Coder Project Initialization Script
# This script helps you set up a new project based on the claudeflow-starter template

set -e

echo "🚀 ClaudeFlow + Coder Project Initialization"
echo "=============================================="
echo ""

# Get project information
read -p "📝 Project name (current directory: $(basename $(pwd))): " PROJECT_NAME
PROJECT_NAME=${PROJECT_NAME:-$(basename $(pwd))}

read -p "📄 Project description: " PROJECT_DESC
PROJECT_DESC=${PROJECT_DESC:-"AI-powered development environment with Coder and ClaudeFlow"}

read -p "👤 Your GitHub username: " GITHUB_USER
read -p "📧 Your email: " USER_EMAIL

echo ""
echo "⚙️ Configuration:"
echo "  Project: $PROJECT_NAME"
echo "  Description: $PROJECT_DESC"  
echo "  GitHub User: $GITHUB_USER"
echo "  Email: $USER_EMAIL"
echo ""

read -p "Continue? (y/N): " CONFIRM
if [[ ! $CONFIRM =~ ^[Yy]$ ]]; then
    echo "❌ Initialization cancelled"
    exit 1
fi

echo ""
echo "🔧 Setting up your project..."

# Update package.json
if [ -f "package.json" ]; then
    echo "📦 Updating package.json..."
    sed -i.bak "s/claudeflow-coder-starter/$PROJECT_NAME/g" package.json
    sed -i.bak "s/Minimal starter template.*/$PROJECT_DESC/g" package.json
    sed -i.bak "s/your-org/$GITHUB_USER/g" package.json
    rm package.json.bak
fi

# Update README.md
if [ -f "README.md" ]; then
    echo "📖 Updating README.md..."
    sed -i.bak "s/ClaudeFlow + Coder Starter/$PROJECT_NAME/g" README.md
    sed -i.bak "s/your-org/$GITHUB_USER/g" README.md
    sed -i.bak "s/your-username/$GITHUB_USER/g" README.md
    sed -i.bak "s/claudeflow-starter/$PROJECT_NAME/g" README.md
    rm README.md.bak
fi

# Update docker-compose.yml container names
if [ -f "docker-compose.yml" ]; then
    echo "🐳 Updating Docker configuration..."
    sed -i.bak "s/container_name: coder/container_name: ${PROJECT_NAME}-coder/g" docker-compose.yml
    sed -i.bak "s/container_name: coder-postgres/container_name: ${PROJECT_NAME}-postgres/g" docker-compose.yml
    rm docker-compose.yml.bak
fi

# Initialize git if not already initialized
if [ ! -d ".git" ]; then
    echo "🔄 Initializing git repository..."
    git init
    git config user.name "$GITHUB_USER"
    git config user.email "$USER_EMAIL"
fi

# Create initial commit
echo "💾 Creating initial commit..."
git add .
git commit -m "Initial commit: $PROJECT_NAME

🚀 AI-powered development environment with:
- Coder cloud workspaces
- ClaudeFlow multi-agent orchestration  
- Claude Code CLI integration
- Pre-configured development tools

Generated from claudeflow-starter template"

# Initialize claude-flow with SPARC framework
echo "🤖 Initializing ClaudeFlow with SPARC framework..."
if command -v claude-flow &> /dev/null; then
    claude-flow init --sparc
    echo "✨ SPARC framework initialized!"
else
    echo "⚠️  claude-flow not found. Install it first with: npm install -g @ruvnet/claude-flow"
    echo "   Then run: claude-flow init --sparc"
fi

# Remove this init script
echo "🧹 Cleaning up..."
rm -f scripts/init-project.sh

echo ""
echo "✅ Project initialization complete!"
echo ""
echo "🔥 Next steps:"
echo "1. Push to GitHub:"
echo "   git remote add origin https://github.com/$GITHUB_USER/$PROJECT_NAME"
echo "   git push -u origin main"
echo ""
echo "2. Start your development environment:"
echo "   docker compose up -d"
echo ""
echo "3. Create Coder workspace:"
echo "   coder templates create claude-flow template/"
echo "   coder create my-workspace --template=claude-flow"
echo ""
echo "4. Access your workspace:"
echo "   coder ssh my-workspace"
echo "   # Then run: claude auth login"
echo ""
echo "🎉 Happy coding with AI assistance!"