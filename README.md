# Dotfiles

Personal dotfiles configuration for macOS and Linux systems.

## Quick Start

### Clone and Setup

```bash
git clone <repository-url> ~/dotfiles
cd ~/dotfiles
./setup.sh
```

### Sync Configurations

Use the sync script to manage configurations between this repository and your system:

```bash
# Sync from dotfiles to local config
./sync.sh --to-local

# Sync from local config back to dotfiles
./sync.sh --from-local
```

## Platform Support

> [!NOTE] Setup covers the tools and configurations, platform specific window managers and status bars aren't covered at the moment.

### macOS

- **Window Manager**: Aerospace
- **Menu Bar**: SketchyBar -- _keeping for reference but no longer used/maintained_

### Linux

- **Window Manager**: i3
- **Status Bar**: Polybar
- **Application Launcher**: Rofi
- **Compositor**: Picom

#### Steam Deck Specific

This configuration works on Steam Deck desktop environment.

It installs all dependencies using `distrobox` on an isolated Arch Linux distro, this means SteamOS updates won't break your dev environment.

To get to your dev env after install, just run:

```sh
distrobox enter devbox
```

## Cross-Platform Tools

- **Terminal**: WezTerm (both platforms)
- **Shell**: Zsh (+OhMyZsh plugins) with Starship prompt (both platforms)
- **Shell Tools**: eza, zoxide, fzf etc...
- **Editor**: Neovim with LazyVim configuration
- **File Manager**: Yazi

## Keybindings

### Window Managers (i3/Aerospace)

| Action                   | Binding                                  |
| ------------------------ | ---------------------------------------- |
| **Mod Key**              | Alt                                      |
| **Navigation**           |                                          |
| Focus left/down/up/right | `Alt + h/j/k/l`                          |
| Move window              | `Alt + Shift + h/j/k/l`                  |
| **Window Management**    |                                          |
| Open terminal            | `Alt + Enter`                            |
| Close window             | `Alt + Shift + q`                        |
| Toggle fullscreen        | `Alt + f`                                |
| **Layouts**              |                                          |
| Stacking/accordion       | `Alt + s`                                |
| Tabbed/accordion         | `Alt + w`                                |
| Toggle split             | `Alt + e`                                |
| Toggle floating          | `Alt + Shift + Space`                    |
| **Workspaces**           |                                          |
| Switch workspace         | `Alt + 1-10`                             |
| Move to workspace        | `Alt + Shift + 1-10`                     |
| **Other**                |                                          |
| Application launcher     | `Alt + d` (Linux - Rofi)                 |
| Enter resize mode        | `Alt + r`                                |
| Resize mode actions      | `h` = shrink width, `l` = expand width   |
|                          | `k` = expand height, `j` = shrink height |
| Resize mode exit         | `Escape` or `Enter`                      |
| Reload config            | `Alt + Shift + c`                        |

### Session Management

WezTerm and LazyVim provide session management features that allow for easy resume of workspaces and terminal sessions after system or app restarts.

**WezTerm**:

- Workspaces are named and can be created dynamically
- Automatic session saving every 5 minutes
- Full workspace state restoration including:
  - Pane layouts and positioning
  - Working directories
  - Command history
  - Tab organization
- **Save Session**: `Leader + S` - Manually save current workspace state (uses workspace name)
- **Load Session**: `Leader + T` - Fuzzy search and restore saved sessions
- **Delete Session**: `Leader + D` - Remove saved sessions
- Sessions are organized by workspace names for easy identification

When creating a new workspace (`Leader + Q`), existing saved state for that name is automatically restored.
This means, combined with LazyVim's session management, users can maintain their coding environment across reboots by either remembering the workspace name or using the fuzzy search from saved sessions and using that as the workspace name.

### WezTerm Terminal

**Leader key**: `Shift+Space`

| Category                 | Binding               | Action                            |
| ------------------------ | --------------------- | --------------------------------- |
| **Pane Navigation**      | `Leader + h/j/k/l`    | Navigate between panes            |
| **Pane Management**      | `Leader + J`          | Split pane vertically             |
|                          | `Leader + L`          | Split pane horizontally           |
|                          | `Leader + f`          | Toggle pane zoom                  |
|                          | `Leader + s`          | Swap panes                        |
|                          | `Cmd + w`             | Close current pane (confirm)      |
| **Tab Management**       | `Leader + 1-8`        | Move tab to position              |
|                          | `Leader + ,`          | Rename current tab                |
| **Workspace Management** | `Leader + w/q`        | Switch to next/previous workspace |
|                          | `Leader + R`          | Rename current workspace          |
|                          | `Leader + Q`          | Create new workspace              |
|                          | `Leader + W`          | Show workspace launcher           |
|                          | `Leader + K`          | Kill all panes in workspace       |
| **Domain Management**    | `Leader + A`          | Attach to unix domain             |
|                          | `Leader + Z`          | Detach from unix domain           |
| **Session Management**   | `Leader + S`          | Save session/workspace state      |
|                          | `Leader + T`          | Load saved session (fuzzy search) |
|                          | `Leader + D`          | Delete saved session              |
| **Resize**               | `Leader + r`          | Enter resize mode                 |
|                          | Resize mode: `h`      | Shrink width                      |
|                          | Resize mode: `l`      | Expand width                      |
|                          | Resize mode: `k`      | Expand height                     |
|                          | Resize mode: `j`      | Shrink height                     |
|                          | Resize mode: `Escape` | Exit resize mode                  |

## Contributing

This is a personal dotfiles repository. Feel free to fork and adapt for your own use.
