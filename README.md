# Claude Code Learned Skills

> A collection of practical patterns and best practices learned through real-world Claude Code usage

This repository contains **24 battle-tested skills** extracted from actual Claude Code development sessions, organized into **global** (cross-project) and **project-specific** collections.

**English** | [日本語](README.ja.md)

## Directory Structure

```
├── global/                    # Cross-project skills (~/.claude/skills/learned/)
│   ├── architecture/          # System design patterns
│   ├── claude-code/           # Claude Code operation patterns
│   ├── llm/                   # LLM integration patterns
│   ├── process/               # Development process patterns
│   └── python/                # Python-specific patterns
└── projects/                  # Project-specific skills (.claude/skills/learned/)
    └── zenn-content/          # Zenn article writing patterns
```

---

## Global Skills (18)

Skills installed to `~/.claude/skills/learned/` — available across all projects.

### Architecture (2)

| Skill | Problem | Solution |
|-------|---------|----------|
| [AI Era Architecture Principles](global/architecture/ai-era-architecture-principles.md) | Traditional architecture patterns don't fit AI-powered applications | Micro-Dependencies principle, LLM composability, context window optimization |
| [Service Layer Extraction](global/architecture/service-layer-extraction.md) | CLI modules mix business logic and UI concerns | Extract testable service layer from Typer/Click CLI modules |

### Claude Code (7)

| Skill | Problem | Solution |
|-------|---------|----------|
| [Claude Code Tool Patterns](global/claude-code/claude-code-tool-patterns.md) | Large file write perf, Edit refresh errors, Hook JSON escape traps | Consolidated gotchas for Claude Code tool operations |
| [Claude Code Self-Generation over API](global/claude-code/claude-code-self-generation-over-api.md) | Reaching for external APIs when Claude Code can generate directly | Use Claude Code's built-in LLM capability before calling external APIs |
| [Claude Code MCP Manual Install](global/claude-code/claude-code-mcp-manual-install.md) | MCP server CLI installer unavailable in session | Manual JSON edit workaround for `~/.claude.json` mcpServers |
| [Parallel Subagent Batch Merge](global/claude-code/parallel-subagent-batch-merge.md) | Sequential data generation is too slow | Parallel subagent batch generation with multi-format merge |
| [Skill Stocktaking Process](global/claude-code/skill-stocktaking-process.md) | Skills accumulate without review, hitting Character Budget | 4-step consolidation with 3-tier organization and timing triggers |
| [Directory Structure Enforcement Hooks](global/claude-code/directory-structure-enforcement-hooks.md) | Files placed in wrong directories | Claude Code hooks to auto-enforce directory structure rules |
| [Cross-Source Fact Verification](global/claude-code/cross-source-fact-verification.md) | Draft articles contain inaccurate dates, counts, sequences | 5-step cross-referencing across debug logs, MEMORY, git, timestamps |

### LLM (3)

| Skill | Problem | Solution |
|-------|---------|----------|
| [CJK-Aware Text Metrics](global/llm/cjk-aware-text-metrics.md) | Token count estimation wrong for mixed CJK/Latin text | Weighted estimation formula for multilingual LLM pipelines |
| [Data Generation Quality Metrics Loop](global/llm/data-generation-quality-metrics-loop.md) | Auto-generated data quality is inconsistent | Quantitative metrics loop for iterative quality improvement |
| [Deep Research API Landscape](global/llm/deep-research-api-landscape.md) | Tempted to use Playwright for deep research automation | 3 major providers offer official Deep Research APIs (2026) |

### Process (3)

| Skill | Problem | Solution |
|-------|---------|----------|
| [Root Cause Challenge Pattern](global/process/root-cause-challenge-pattern.md) | Surface-level fixes instead of finding root cause | 5-step decision framework: challenge assumptions before adding complexity |
| [Brainstorming Communication](global/process/brainstorming-communication.md) | AI gives premature concrete solutions during ideation | Communication protocol for idea exploration vs implementation phases |
| [JSON Data Validation Test Design](global/process/json-data-validation-test-design.md) | Large JSON data files lack validation | Schema, source data, and business rule validation test design |

### Python (3)

| Skill | Problem | Solution |
|-------|---------|----------|
| [Python Immutable Accumulator](global/python/python-immutable-accumulator.md) | Need to accumulate results without mutation | Frozen dataclass + tuple accumulation with `__slots__` gotcha |
| [Python Optional Dependencies](global/python/python-optional-dependencies.md) | Heavy dependencies forced on users who don't need them | pyproject.toml extras, runtime checks, factory pattern |
| [Python Module-to-Package Refactor](global/python/python-module-to-package-refactor.md) | Single module grew too large | Module-to-package refactoring with `mock.patch` target updates |

---

## Project-Specific Skills (6)

Skills installed to `.claude/skills/learned/` within individual projects.

### zenn-content (6)

Patterns specific to Zenn/Qiita technical article writing.

| Skill | Problem | Solution |
|-------|---------|----------|
| [Tech Writing Patterns](projects/zenn-content/tech-writing-patterns.md) | Inconsistent article quality and tone | Cross-posting, tone adjustment, technical article quality patterns |
| [Zenn Context-Driven Writing](projects/zenn-content/zenn-context-driven-writing.md) | Articles written without structured preparation | Context collection and structuring workflow before drafting |
| [Zenn-Qiita Crosspost Workflow](projects/zenn-content/zenn-qiita-crosspost-workflow.md) | Manual cross-posting is error-prone | Automated Zenn-to-Qiita conversion with format mapping |
| [prh Hyphen Regex Escape](projects/zenn-content/prh-hyphen-regex-escape.md) | Node.js 20+ unicode regex rejects `\-` in prh patterns | Avoid hyphen-containing patterns in prh.yml |
| [Zenn markdownlint Config](projects/zenn-content/zenn-markdownlint-config.md) | Default markdownlint rules conflict with Zenn syntax | Disable MD025/MD041/MD060/MD013; no globs in config |
| [Zenn textlint Workarounds](projects/zenn-content/zenn-textlint-workarounds.md) | textlint false positives on Zenn-specific syntax | Known false positives and workarounds for Zenn articles |

---

## Usage

### Installing Global Skills

```bash
# Copy all global skills (preserving categories)
cp -r global/*/ ~/.claude/skills/learned/

# Or copy individual skills
cp global/python/python-immutable-accumulator.md ~/.claude/skills/learned/
```

### Installing Project Skills

```bash
# Copy project-specific skills to your project
cp -r projects/zenn-content/ your-project/.claude/skills/learned/
```

---

## Contributing

1. **Share your learned skills** — Extract patterns from your own Claude Code sessions
2. **Improve existing skills** — Add examples, clarify explanations
3. **Add new projects** — Create `projects/your-project/` with project-specific skills

### Skill Format

```markdown
# Skill Name

**Extracted:** YYYY-MM-DD
**Context:** Brief description of the problem context

## Problem
Clear statement of the problem this skill solves

## Solution
Concrete solution with code examples

## When to Use
Specific scenarios where this skill applies
```

---

## License

MIT License — see [LICENSE](LICENSE) file for details

---

**Created by:** [@shimo4228](https://github.com/shimo4228)
**Last Updated:** 2026-02-14
