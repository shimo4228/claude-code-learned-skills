# Claude Code Learned Skills

> A collection of practical patterns and best practices learned through real-world Claude Code usage

This repository contains **39 battle-tested skills** extracted from actual Claude Code development sessions, following the [Agent Skills standard](https://agentskills.io/specification).

**English** | [日本語](README.ja.md)

## Directory Structure

```
skills/
├── ai-era-architecture-principles/SKILL.md
├── brainstorming-communication/SKILL.md
├── cjk-aware-text-metrics/SKILL.md
├── ...
└── zenn-textlint-workarounds/SKILL.md
```

Each skill lives in `skills/{skill-name}/SKILL.md` with YAML frontmatter for discovery by Agent Skills-compatible tools.

---

## Skills (39)

### Architecture

| Skill | Description |
|-------|-------------|
| [ai-era-architecture-principles](skills/ai-era-architecture-principles/SKILL.md) | Framework adoption decision matrix: custom vs large frameworks in the Claude Code era |
| [algorithm-migration-with-rollback](skills/algorithm-migration-with-rollback/SKILL.md) | Rollback-safe migration pattern for core algorithms (encryption, hashing, ML) with persisted data |
| [service-layer-extraction](skills/service-layer-extraction/SKILL.md) | Extract business logic from Typer/Click CLI into a testable service layer |

### Claude Code

| Skill | Description |
|-------|-------------|
| [claude-code-tool-patterns](skills/claude-code-tool-patterns/SKILL.md) | Large file write perf, Edit refresh pattern, Hook JSON escape trap |
| [claude-code-self-generation-over-api](skills/claude-code-self-generation-over-api/SKILL.md) | Try self-generation before API calls on Max plan |
| [claude-code-mcp-manual-install](skills/claude-code-mcp-manual-install/SKILL.md) | Add MCP servers from within a session via jq-based ~/.claude.json editing |
| [parallel-subagent-batch-merge](skills/parallel-subagent-batch-merge/SKILL.md) | Generate 50+ items with parallel subagents and merge outputs |
| [skill-stocktaking-process](skills/skill-stocktaking-process/SKILL.md) | 4-step skill consolidation with character budget awareness |
| [directory-structure-enforcement-hooks](skills/directory-structure-enforcement-hooks/SKILL.md) | PreToolUse + Stop hook 3-layer defense for directory rules |
| [cross-source-fact-verification](skills/cross-source-fact-verification/SKILL.md) | Fact-check drafts against multiple independent sources |

### LLM

| Skill | Description |
|-------|-------------|
| [cjk-aware-text-metrics](skills/cjk-aware-text-metrics/SKILL.md) | CJK/Latin weighted token estimation for multilingual pipelines |
| [cost-aware-llm-pipeline](skills/cost-aware-llm-pipeline/SKILL.md) | LLM cost control via model routing, budget tracking, retry, and prompt caching |
| [data-generation-quality-metrics-loop](skills/data-generation-quality-metrics-loop/SKILL.md) | Iterative generate-measure-fix loops with quantitative metrics |
| [deep-research-api-landscape](skills/deep-research-api-landscape/SKILL.md) | Official Deep Research APIs (OpenAI, Gemini, Perplexity) over browser automation |
| [keyword-based-llm-eval](skills/keyword-based-llm-eval/SKILL.md) | Evaluate LLM-generated structured output with keyword matching and F1 metrics |
| [long-document-llm-pipeline](skills/long-document-llm-pipeline/SKILL.md) | Process 50K+ char documents through LLM APIs with section splitting and batch cost reduction |
| [regex-vs-llm-structured-text](skills/regex-vs-llm-structured-text/SKILL.md) | Parse structured text with regex first, add LLM only for low-confidence edge cases |

### Process

| Skill | Description |
|-------|-------------|
| [root-cause-challenge-pattern](skills/root-cause-challenge-pattern/SKILL.md) | 5-step decision framework: challenge assumptions before adding complexity |
| [brainstorming-communication](skills/brainstorming-communication/SKILL.md) | Communication protocol for idea exploration vs implementation phases |
| [json-data-validation-test-design](skills/json-data-validation-test-design/SKILL.md) | Layered pytest validation for auto-generated JSON data |

### Python

| Skill | Description |
|-------|-------------|
| [backward-compatible-frozen-extension](skills/backward-compatible-frozen-extension/SKILL.md) | Extend frozen dataclass or Pydantic pipeline with new fields without breaking consumers |
| [content-hash-cache-pattern](skills/content-hash-cache-pattern/SKILL.md) | SHA-256 content-hash keying with frozen CacheEntry for expensive file processing |
| [mock-friendly-api-layering](skills/mock-friendly-api-layering/SKILL.md) | Fix mock assertion failures from public functions forwarding internal params to shared helpers |
| [python-immutable-accumulator](skills/python-immutable-accumulator/SKILL.md) | Frozen dataclass + tuple accumulation with `__slots__` gotcha |
| [python-optional-dependencies](skills/python-optional-dependencies/SKILL.md) | pyproject.toml extras, runtime checks, factory pattern |
| [python-module-to-package-refactor](skills/python-module-to-package-refactor/SKILL.md) | Module-to-package refactoring with `mock.patch` target updates |
| [textual-tui-pipeline-interception](skills/textual-tui-pipeline-interception/SKILL.md) | Add interactive review/approval step to CLI pipeline using Textual TUI |

### Swift / iOS

| Skill | Description |
|-------|-------------|
| [immutable-model-updates](skills/immutable-model-updates/SKILL.md) | Thread-safe immutable state updates for Swift model structs |
| [protocol-di-testing](skills/protocol-di-testing/SKILL.md) | Test Swift code with protocol-based dependency injection for file system, network, APIs |
| [swift-actor-persistence](skills/swift-actor-persistence/SKILL.md) | Thread-safe data persistence layer using Swift actors with in-memory cache and file storage |
| [swift-codable-decode-diagnosis](skills/swift-codable-decode-diagnosis/SKILL.md) | Debug Swift Codable JSON decode errors with vague localizedDescription messages |
| [xcode-package-swift-misidentification](skills/xcode-package-swift-misidentification/SKILL.md) | Fix simulator launch failure caused by Package.swift misidentification |
| [xcode-pbxproj-file-registration](skills/xcode-pbxproj-file-registration/SKILL.md) | Register .swift files added outside Xcode in 4 pbxproj sections |

### Tech Writing (Zenn/Qiita)

| Skill | Description |
|-------|-------------|
| [tech-writing-patterns](skills/tech-writing-patterns/SKILL.md) | Cross-posting, tone adjustment, quality patterns |
| [zenn-context-driven-writing](skills/zenn-context-driven-writing/SKILL.md) | Context collection and structuring workflow before drafting |
| [zenn-qiita-crosspost-workflow](skills/zenn-qiita-crosspost-workflow/SKILL.md) | Automated Zenn-to-Qiita conversion pipeline |
| [prh-hyphen-regex-escape](skills/prh-hyphen-regex-escape/SKILL.md) | Node.js 20+ unicode regex incompatibility with prh hyphen patterns |
| [zenn-markdownlint-config](skills/zenn-markdownlint-config/SKILL.md) | Zenn-specific markdownlint-cli2 rule overrides |
| [zenn-textlint-workarounds](skills/zenn-textlint-workarounds/SKILL.md) | Known false positives and workarounds for Zenn articles |

---

## Usage

### Install individual skills

```bash
# Copy a single skill to your global learned skills
cp skills/python-immutable-accumulator/SKILL.md \
   ~/.claude/skills/learned/python-immutable-accumulator.md

# Or to a project
cp skills/zenn-markdownlint-config/SKILL.md \
   your-project/.claude/skills/learned/zenn-markdownlint-config.md
```

### Install all skills

```bash
# Copy all skills (as flat .md files for Claude Code compatibility)
for dir in skills/*/; do
  name=$(basename "$dir")
  cp "$dir/SKILL.md" ~/.claude/skills/learned/"$name".md
done
```

---

## Agent Skills Standard

Each `SKILL.md` includes YAML frontmatter following the [Agent Skills specification](https://agentskills.io/specification):

```yaml
---
name: skill-name
description: "Use when ... trigger phrase. Brief description."
license: MIT
metadata:
  author: shimo4228
  version: "1.0"
  extracted: "2026-02-08"
---
```

Compatible with:
- [agnix](https://www.npmjs.com/package/agnix) — Agent Skills validator
- [SkillsMP](https://skillsmp.com/) — Agent Skills marketplace
- [SkillHub](https://www.skillhub.club/) — Skill discovery platform

---

## Contributing

1. **Share your learned skills** -- Extract patterns from your own Claude Code sessions
2. **Improve existing skills** -- Add examples, clarify explanations
3. **Report issues** -- Found a gotcha that's outdated? Let us know

### Skill Format

```markdown
---
name: your-skill-name
description: "Use when ... Brief description."
license: MIT
metadata:
  author: your-github-username
  version: "1.0"
  extracted: "YYYY-MM-DD"
---

# Skill Title

**Extracted:** YYYY-MM-DD
**Context:** Brief problem context

## Problem
Clear statement of the problem

## Solution
Concrete solution with code examples

## When to Use
Specific scenarios where this skill applies
```

---

## License

MIT License -- see [LICENSE](LICENSE) file for details

---

**Created by:** [@shimo4228](https://github.com/shimo4228)
**Last Updated:** 2026-02-14
