# Emacs Configuration

Modern Emacs setup for C++ development with LSP support and enhanced navigation.

## Features

- **LSP Mode** - Full language server support for C++ with `clangd`
- **Company** - Fast auto-completion (1 char trigger, Tab/Shift-Tab navigation)
- **Flycheck** - Real-time syntax checking
- **Consult + Vertico** - Enhanced fuzzy search and buffer/file navigation with live previews
- **Orderless** - Flexible completion matching

## UI

- Atom One Dark theme
- Global line numbers
- Electric pair mode (auto-close brackets/quotes)
- Clean interface (no menu/tool/scroll bars)

## Key Bindings

- `C-x b` - Buffer switching with preview
- `C-x C-g` - Recent files
- `M-g i` - Jump to symbol
- `M-s l` - Search lines
- `M-s r` - Ripgrep search
- `M-up`/`M-down` - Move Up/Down the current line

## Installation

1. Copy to `~/.emacs.d/init.el`
2. Start Emacs (packages auto-install)
3. Install `clangd` for C++ LSP support

## Requirements

- Emacs 27.1+
- `clangd` (for C++ development)
- `ripgrep` (optional, for faster search)
