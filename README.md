# ELIPS configuration

## Structure

```bash
~/.emacs.d/
├── init.el              # Main entry point
├── custom.el            # Auto-generated custom variables
└── lisp/
    ├── common.el        # Theme, UI, completion, general settings
    ├── git.el           # Magit, git-gutter, git-timemachine
    ├── rust.el          # Rust mode, cargo commands
    ├── python.el        # Python mode, pyvenv
    ├── markdown.el      # Markdown mode
    ├── web.el           # TypeScript, JavaScript, JSON
    ├── php.el           # PHP mode
    ├── bash.el          # Shell scripting
    ├── devops.el        # Docker, Kubernetes, Ansible, Terraform
    ├── data-formats.el  # YAML, XML, TOML, CSV
    ├── cpp.el           # C/C++, LLVM, Clang, CMake
    └── other.el         # Every other config file in the future
```

## Setup

Remove the inside of `~/.emacs.d` 

```bash
rm -rf ~/.emacs.d/* && mv elispconf ~/.emacs.d/
```

Copy each file that you want on path `~/.emacs.d`.
