# Workspace Templates

## Template Structure

```
template/
├── main.tf              # Terraform configuration
└── build/
    └── Dockerfile       # Container image
```

## Customizing the Template

### Adding Software

Edit `template/build/Dockerfile`:

```dockerfile
# Add additional packages
RUN apt-get update && apt-get install -y \
    your-package-here \
    && rm -rf /var/lib/apt/lists/*

# Install language-specific tools
RUN npm install -g your-npm-package
RUN pip3 install your-python-package
```

### Adding VS Code Extensions

```dockerfile
RUN code-server --install-extension publisher.extension-name
```

### Configuring Resources

Edit parameters in `template/main.tf`:

```hcl
data "coder_parameter" "cpu" {
  # Add more CPU options
  option {
    name  = "16 Cores"
    value = "16"
  }
}
```

### Adding Environment Variables

```hcl
resource "coder_agent" "main" {
  env = {
    YOUR_VAR = "value"
  }
}
```

## Updating Templates

```bash
# Update template after changes
coder templates push claude-flow template/

# Verify template
coder templates show claude-flow
```

## Multiple Templates

Create variations:

```bash
# Copy template
cp -r template template-python

# Modify for Python development
# Update template/build/Dockerfile with Python-specific tools

# Create new template
coder templates create claude-flow-python template-python/
```

## Best Practices

1. **Keep images lean** - Only install what you need
2. **Use specific versions** - Pin package versions for reproducibility  
3. **Test locally** - Build Docker image locally before pushing template
4. **Document changes** - Update README when modifying templates