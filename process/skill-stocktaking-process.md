# Skill File Stocktaking Process

**Extracted:** 2026-02-09
**Context:** When learned skill files accumulate (~10-15 files) and need consolidation to reduce noise and keep MEMORY.md concise.

## Problem

Frequent `/learn` usage creates skill file sprawl:
- Similar skills covering sub-steps of the same pipeline
- Small gotcha files that belong as sections in larger skills
- MEMORY.md references grow, approaching the 200-line system limit
- Noise makes it harder to find relevant skills

## Solution: 4-Step Stocktaking

### Step 1: Inventory and Classify

Read all files in `~/.claude/skills/learned/` and classify by:
- **Project** (which project produced this skill)
- **Domain** (immutability, LLM pipeline, testing, etc.)
- **Granularity** (full pattern vs. single gotcha/tip)

### Step 2: Identify Consolidation Candidates

Look for these overlap patterns:

| Pattern | Example | Action |
|---------|---------|--------|
| **Sub-step of larger pipeline** | pymupdf extraction is Step 1 of long-doc pipeline | Merge into parent |
| **Small gotcha for a topic** | frozen+slots TypeError is a gotcha for immutable accumulator | Add as "Gotcha" section |
| **Same concept, different language** | Swift immutable models + Python immutable accumulator | Keep separate (different audiences) |
| **Truly distinct concerns** | Cost tracking vs. backward compat | Keep separate |

### Step 3: Execute Consolidation

For each merge:
1. Read the target (larger) skill file
2. Integrate content from the smaller file as a new section
3. Delete the absorbed file
4. Verify no information was lost

### Step 4: Update MEMORY.md

- Remove references to deleted files
- Add "(N skills consolidated)" annotation
- Compress verbose entries (details belong in skill files, not MEMORY.md)
- Verify line count stays well under 200

## Timing Guidelines

| Trigger | Action |
|---------|--------|
| 10-15 learned skills accumulated | Full stocktaking |
| MEMORY.md exceeds 100 lines | Compress and move details to skill files |
| Project phase changes | Remove obsolete findings |
| Same topic has 3+ skill files | Consolidate immediately |

## When to Use

- Periodically when `/learn` has been used frequently
- When MEMORY.md feels cluttered
- Before starting a major new project phase
- When session startup feels slow due to large MEMORY.md
