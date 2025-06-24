#!/bin/bash
# Verify that all tools are properly installed and accessible

echo "🔍 Verifying ClaudeFlow + Coder DevContainer Setup"
echo "=================================================="
echo ""

# Check PATH
echo "📍 Current PATH:"
echo "$PATH" | tr ':' '\n' | grep npm
echo ""

# Check npm global directory
echo "📦 NPM global directory:"
npm config get prefix
echo ""

# Check installed global packages
echo "📋 Installed global packages:"
npm list -g --depth=0 2>/dev/null | grep -E "(claude|typescript|vite|jest|eslint|prettier)" || echo "No packages found!"
echo ""

# Check tool availability
echo "🔧 Tool availability:"
tools=(
    "claude:Claude Code CLI"
    "claude-flow:ClaudeFlow multi-agent orchestration"
    "tsc:TypeScript compiler"
    "tsx:TypeScript execute"
    "vite:Vite build tool"
    "jest:Jest testing framework"
    "eslint:ESLint linter"
    "prettier:Prettier formatter"
    "create-react-app:Create React App"
    "create-next-app:Create Next App"
)

for tool_info in "${tools[@]}"; do
    IFS=':' read -r tool desc <<< "$tool_info"
    if command -v "$tool" &> /dev/null; then
        echo "✅ $tool - $desc"
    else
        echo "❌ $tool - $desc (NOT FOUND)"
    fi
done

echo ""

# Check aliases
echo "🔤 Checking aliases:"
if type c &> /dev/null; then
    echo "✅ 'c' alias for claude"
else
    echo "❌ 'c' alias not found"
fi

if type cf &> /dev/null; then
    echo "✅ 'cf' alias for claude-flow"
else
    echo "❌ 'cf' alias not found"
fi

if type swarm &> /dev/null; then
    echo "✅ 'swarm' alias for parallel execution"
else
    echo "❌ 'swarm' alias not found"
fi

echo ""
echo "🎯 Setup verification complete!"
echo ""

# Final check
if command -v claude &> /dev/null && command -v claude-flow &> /dev/null; then
    echo "✨ DevContainer is ready! Next step: Run 'claude auth login'"
else
    echo "⚠️  Some tools are missing. Please check the setup."
    echo "   Try running: source ~/.bashrc"
fi