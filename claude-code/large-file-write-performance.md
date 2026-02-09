# Large File Write Performance Pattern

**Extracted:** 2026-02-09
**Context:** Writing comprehensive documentation or large code files

## Problem

When attempting to write very large files (>3000 lines, ~4000+ lines) in a single Write tool call, the operation becomes extremely slow and may appear to hang, causing user frustration and potential interruption.

**Symptoms:**
- Write operation takes >60 seconds
- User interrupts thinking it's stuck
- No feedback on progress

**Root Cause:**
- Single large Write operations lack incremental feedback
- File I/O for large content has O(n) time complexity
- No streaming or chunked writes available

## Solution

**Split large files into modular components** instead of writing a single monolithic file:

1. **Identify logical boundaries** (chapters, sections, domains)
2. **Create multiple focused files** (200-800 lines each)
3. **Add navigation file** (README/index) to tie them together
4. **Write files in parallel** when possible

## Example

**Before (Problem):**
```markdown
# Write single file
/docs/architecture.md (4000 lines)
→ Takes 90+ seconds, user interrupts
```

**After (Solution):**
```markdown
# Split into modular files
/docs/architecture/
├── README.md (200 lines) - Navigation
├── 00-overview.md (600 lines)
├── 01-adr-backend.md (500 lines)
├── 02-adr-data.md (800 lines)
├── 03-scalability.md (600 lines)
├── 04-workflow.md (700 lines)
├── 05-security.md (600 lines)
├── 06-integration.md (700 lines)
└── 07-roadmap.md (700 lines)

→ Each write completes in ~5-10 seconds
→ Better organization and maintainability
```

## When to Use

**Trigger Conditions:**
- Planning to write a file >1000 lines
- Creating comprehensive documentation
- Generating large configuration files
- Consolidating multiple agent outputs

**Benefits:**
- Faster write operations (parallel execution possible)
- Better modularity and maintainability
- Easier navigation for users
- Incremental progress visibility
- Follows "Small Files, Deep Focus" design principle

## Related Patterns

- Repository pattern (split by domain)
- Documentation-as-code (modular docs)
- ADR (Architecture Decision Records) - naturally splits into multiple files
