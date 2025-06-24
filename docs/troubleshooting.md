# Troubleshooting

## Common Issues

### Coder Server Won't Start

**Symptoms**: `docker compose up` fails or Coder UI unreachable

**Solutions**:
```bash
# Check container status
docker compose ps

# View logs
docker compose logs coder

# Check if ports are in use
sudo lsof -i :7080

# Restart services
docker compose restart
```

### Workspace Creation Fails

**Symptoms**: Template creation or workspace creation errors

**Solutions**:
```bash
# Validate Terraform template
cd template && terraform validate

# Check Docker daemon
docker info

# View workspace build logs
coder templates show claude-flow

# Check resource constraints
docker system df
```

### Can't Access Workspace

**Symptoms**: SSH or web access fails

**Solutions**:
```bash
# Check workspace status
coder list

# View agent logs
coder logs my-workspace

# Restart workspace
coder stop my-workspace
coder start my-workspace

# Check network connectivity
coder ping my-workspace
```

### Claude Code Permission Errors

**Symptoms**: "Permission denied" or file access errors with `claude` command

**Solutions**:
```bash
# Use convenient bypass alias for container environments
claude go "your command"
claude go "analyze code"

# Continue conversation with follow-up (includes permission bypass)
claude continue "implement the suggested fix"

# Check file permissions if issues persist
ls -la /path/to/your/files

# Ensure proper workspace ownership
sudo chown -R $(whoami):$(whoami) ~/
```

### Claude-Flow Not Working

**Symptoms**: `cf` command not found or claude-flow errors

**Solutions**:
```bash
# SSH into workspace
coder ssh my-workspace

# Check pre-installed packages
which claude
which claude-flow
npm list -g @anthropic-ai/claude-code
npm list -g @ruvnet/claude-flow

# Reinstall if missing (should be pre-installed)
npm install -g @anthropic-ai/claude-code
npm install -g @ruvnet/claude-flow

# Check aliases
source ~/.bashrc
alias | grep -E "(claude|cf)"
```

**Note**: Both packages should be pre-installed in all container environments. If missing, there may be an issue with the container build.

### Performance Issues

**Symptoms**: Slow workspace or resource errors

**Solutions**:
```bash
# Check resource usage
docker stats

# Monitor workspace resources
coder stat my-workspace

# Increase workspace resources
coder create new-workspace \
  --template=claude-flow \
  --parameter="cpu=4" \
  --parameter="memory=8"
```

## Getting Help

1. **Check logs**: Always start with `docker compose logs` and `coder logs`
2. **Resource limits**: Ensure adequate CPU/memory/disk space
3. **Network issues**: Verify Docker networking and port accessibility
4. **Clean state**: Try recreating workspace if issues persist

## Useful Commands

```bash
# Coder status
coder list
coder stat my-workspace

# Docker debugging
docker compose ps
docker compose logs
docker system df
docker system prune

# System resources
free -h
df -h
top
```