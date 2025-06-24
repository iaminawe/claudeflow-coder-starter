#!/bin/bash

# Setup Claude aliases for easier command usage
# This script adds convenient aliases to your shell configuration

echo "🔧 Setting up Claude aliases..."

# Function to add aliases to shell config
add_claude_aliases() {
    local shell_config="$1"
    
    # Check if aliases already exist
    if grep -q "claude go" "$shell_config" 2>/dev/null; then
        echo "✅ Claude aliases already configured in $shell_config"
        return
    fi
    
    echo "📝 Adding Claude aliases to $shell_config"
    
    # Add comment header
    echo "" >> "$shell_config"
    echo "# Claude CLI convenient aliases" >> "$shell_config"
    
    # Add basic aliases
    echo 'alias c="claude"' >> "$shell_config"
    echo 'alias cf="claude-flow"' >> "$shell_config"
    echo 'alias cf-swarm="claude-flow swarm --parallel"' >> "$shell_config"
    
    # Add function for go and continue
    cat >> "$shell_config" << 'EOF'
claude() {
    if [ "$1" = "go" ]; then
        shift
        command claude --dangerously-skip-permissions "$@"
    elif [ "$1" = "continue" ]; then
        shift  
        command claude --continue --dangerously-skip-permissions "$@"
    else
        command claude "$@"
    fi
}
EOF
    
    echo "✅ Aliases added to $shell_config"
}

# Detect shell and add aliases
if [ -n "$ZSH_VERSION" ]; then
    # Running in zsh
    add_claude_aliases "$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    # Running in bash
    add_claude_aliases "$HOME/.bashrc"
else
    # Try to detect from $SHELL
    case "$SHELL" in
        */zsh)
            add_claude_aliases "$HOME/.zshrc"
            ;;
        */bash)
            add_claude_aliases "$HOME/.bashrc"
            ;;
        *)
            echo "⚠️  Unknown shell. Please manually add aliases to your shell config:"
            echo ""
            echo "alias c=\"claude\""
            echo "claude() {"
            echo "    if [ \"\$1\" = \"go\" ]; then"
            echo "        shift"
            echo "        command claude --dangerously-skip-permissions \"\$@\""
            echo "    elif [ \"\$1\" = \"continue\" ]; then"
            echo "        shift"
            echo "        command claude --continue --dangerously-skip-permissions \"\$@\""
            echo "    else"
            echo "        command claude \"\$@\""
            echo "    fi"
            echo "}"
            exit 1
            ;;
    esac
fi

echo ""
echo "🎉 Setup complete! Reload your shell or run:"
echo "   source ~/.bashrc   # for bash"
echo "   source ~/.zshrc    # for zsh"
echo ""
echo "📋 Available aliases:"
echo "   claude        - Standard Claude CLI (Anthropic)"
echo "   c             - Short alias for claude"
echo "   claude go     - claude --dangerously-skip-permissions"
echo "   claude continue - claude --continue --dangerously-skip-permissions"
echo "   cf            - claude-flow (multi-agent orchestration)"
echo "   cf-swarm      - claude-flow swarm --parallel"
echo ""
echo "💡 Examples:"
echo "   claude \"analyze my code\"              # Direct Claude assistance"
echo "   c \"debug this function\"               # Short form"
echo "   claude go \"review my project\"         # Bypass permissions"
echo "   claude continue \"fix the issue\"       # Continue + bypass"
echo "   cf architect \"design API\"             # Single agent mode"
echo "   cf-swarm \"build complete feature\"     # Multi-agent parallel"