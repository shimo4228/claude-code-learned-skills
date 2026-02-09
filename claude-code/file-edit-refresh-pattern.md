# File Edit Refresh Pattern

**Extracted:** 2026-02-09
**Context:** Preventing "File has been modified since read" errors during Edit operations

## Problem

When using the Edit tool in long sessions or after multiple file operations, you may encounter this error:

```
Error: File has been modified since read
```

This occurs because the Edit tool validates that file contents match what was last read. If the file state has changed (or the tool believes it has), the edit will fail.

## Solution

**Always refresh file contents with Read before Edit:**

1. Even if you've read the file earlier in the session
2. Even if you believe nothing has changed
3. Especially after using other tools (Bash, Write, etc.)

```python
# Pattern
1. Read(file_path)        # Refresh current state
2. Edit(file_path, ...)   # Now safe to edit
```

## Example

```markdown
# BAD: Edit without recent Read
- Earlier: Read file.py
- (Multiple other operations)
- Later: Edit file.py  # ❌ May fail

# GOOD: Read immediately before Edit
- Earlier: Read file.py
- (Multiple other operations)
- Later: Read file.py   # ✅ Refresh state
- Then: Edit file.py    # ✅ Safe to edit
```

## When to Use

- **Before every Edit call** in sessions with multiple file operations
- After file state might have changed through other tools
- In long-running sessions (context near limits)
- When you see "File has been modified" errors

## Related Errors

This pattern prevents:
- "File has been modified since read"
- Edit tool state validation failures
- Silent edit failures in complex workflows
