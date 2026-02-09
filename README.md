# Claude Code Learned Skills

> A collection of practical patterns and best practices learned through real-world Claude Code usage

This repository contains 15 battle-tested skills extracted from actual Claude Code development sessions. Each skill represents a proven solution to common challenges in AI-assisted software development.

**English** | [日本語](README.ja.md)

## 📚 Categories

- [🛠️ Claude Code Patterns](#-claude-code-patterns) - Claude Code操作パターン
- [🏗️ Architecture Patterns](#️-architecture-patterns) - アーキテクチャパターン
- [🐍 Python Patterns](#-python-patterns) - Python特有のパターン
- [🦅 Swift Patterns](#-swift-patterns) - Swift特有のパターン
- [🤖 LLM Integration Patterns](#-llm-integration-patterns) - LLM活用パターン
- [⚙️ Development Process](#️-development-process) - 開発プロセス

---

## 🛠️ Claude Code Patterns

Patterns for effective Claude Code usage and tool operation.

### [File Edit Refresh Pattern](claude-code/file-edit-refresh-pattern.md)
**Problem:** "File has been modified since read" errors during Edit operations
**Solution:** Always refresh file contents with Read before Edit, especially in long sessions

```python
# Pattern
1. Read(file_path)        # Refresh current state
2. Edit(file_path, ...)   # Now safe to edit
```

**When to use:** Before every Edit call in sessions with multiple file operations

### [Large File Write Performance](claude-code/large-file-write-performance.md)
**Problem:** Slow performance when writing large files
**Solution:** Optimize Write operations for large file handling

**When to use:** When working with files larger than typical code files

---

## 🏗️ Architecture Patterns

System design and architectural decision-making patterns.

### [AI Era Architecture Principles](architecture/ai-era-architecture-principles.md)
**Problem:** Traditional architecture patterns don't fit AI-powered applications
**Solution:** Architecture principles specifically designed for LLM-integrated systems

**Key principles:**
- Design for LLM composability
- Optimize for context window constraints
- Structure for prompt engineering
- Plan for non-deterministic behavior

### [Protocol DI Testing](architecture/protocol-di-testing.md)
**Problem:** Hard to test code with tight coupling to external dependencies
**Solution:** Use Protocol (duck typing) for dependency injection and easy mocking

```python
from typing import Protocol

class Repository(Protocol):
    def find_by_id(self, id: str) -> dict | None: ...
    def save(self, entity: dict) -> dict: ...
```

**Benefits:** Better testability, loose coupling, clear contracts

### [Backward Compatible Frozen Extension](architecture/backward-compatible-frozen-extension.md)
**Problem:** Need to extend immutable dataclasses without breaking existing code
**Solution:** Extend frozen dataclasses while maintaining backward compatibility

**When to use:** When evolving immutable data models in production systems

---

## 🐍 Python Patterns

Python-specific idioms and best practices.

### [Immutable Model Updates](python/immutable-model-updates.md)
**Problem:** Mutation causes hidden side effects and hard-to-debug issues
**Solution:** Use immutable patterns with dataclasses and type safety

```python
from dataclasses import dataclass, replace

@dataclass(frozen=True)
class User:
    name: str
    email: str

# Immutable update
updated_user = replace(user, email="new@example.com")
```

**Benefits:** No side effects, easier debugging, safe concurrency

### [Python Immutable Accumulator](python/python-immutable-accumulator.md)
**Problem:** Need to accumulate results without mutation
**Solution:** Functional accumulation patterns in Python

**When to use:** Data transformations, aggregations, pipeline processing

### [Python Optional Dependencies](python/python-optional-dependencies.md)
**Problem:** Don't want to force users to install heavy dependencies they might not use
**Solution:** Properly handle optional dependencies with graceful degradation

```python
try:
    import expensive_lib
    HAS_EXPENSIVE = True
except ImportError:
    HAS_EXPENSIVE = False

def feature_requiring_lib():
    if not HAS_EXPENSIVE:
        raise ImportError("Install with: pip install package[extra]")
```

---

## 🦅 Swift Patterns

Swift-specific patterns for iOS/macOS development.

### [Swift Actor Persistence](swift/swift-actor-persistence.md)
**Problem:** Thread-safe data persistence in Swift concurrent environments
**Solution:** Use Actor pattern for safe concurrent data access and persistence

```swift
actor DataStore {
    private var cache: [String: Data] = [:]

    func save(_ data: Data, for key: String) async {
        cache[key] = data
        // Persist to disk
    }
}
```

**Benefits:** Thread safety, data race prevention, clean concurrency model

---

## 🤖 LLM Integration Patterns

Patterns for integrating Large Language Models into applications.

### [Cost-Aware LLM Pipeline](llm/cost-aware-llm-pipeline.md)
**Problem:** LLM API costs can spiral out of control
**Solution:** Design pipelines with cost optimization as a first-class concern

**Strategies:**
- Use cheaper models for simple tasks
- Cache results aggressively
- Implement request batching
- Monitor and alert on cost thresholds

### [Long Document LLM Pipeline](llm/long-document-llm-pipeline.md)
**Problem:** Documents exceed LLM context window limits
**Solution:** Multi-stage pipeline for processing long documents

**Approach:**
1. Chunk document intelligently
2. Process chunks with context overlap
3. Aggregate results with summary pass
4. Final synthesis

### [Regex vs LLM Structured Text](llm/regex-vs-llm-structured-text.md)
**Problem:** When to use regex vs LLM for text extraction
**Solution:** Decision framework for choosing the right tool

| Pattern | Use Regex | Use LLM |
|---------|-----------|---------|
| Fixed format | ✅ Fast, reliable | ❌ Overkill |
| Variable format | ❌ Brittle | ✅ Flexible |
| Semantic understanding | ❌ Impossible | ✅ Natural |
| Cost sensitive | ✅ Free | ❌ Pay per call |

---

## ⚙️ Development Process

Workflow and process patterns for development.

### [Algorithm Migration with Rollback](process/algorithm-migration-with-rollback.md)
**Problem:** Risky to replace critical algorithms in production
**Solution:** Implement feature flag system with A/B comparison and rollback

```python
def process_data(data, use_new_algorithm=False):
    if use_new_algorithm:
        return new_algorithm(data)
    else:
        return legacy_algorithm(data)
```

**Steps:** Feature flag → Parallel run → Compare results → Gradual rollout → Full migration

### [Root Cause Challenge Pattern](process/root-cause-challenge-pattern.md)
**Problem:** Stop at surface-level fixes instead of finding root cause
**Solution:** Systematic root cause analysis with "5 Whys" approach

**Process:**
1. State the problem
2. Ask "Why?" to find the cause
3. Repeat "Why?" for each answer (typically 5 times)
4. Identify the root cause
5. Fix at the root level

### [Skill Stocktaking Process](process/skill-stocktaking-process.md)
**Problem:** Learned patterns get forgotten and not reused
**Solution:** Regular review and documentation of learned patterns

**Workflow:**
1. Weekly review of sessions
2. Extract reusable patterns
3. Document as skills
4. Integrate into workflow
5. Share with team

---

## 🚀 Usage

### Installing Skills

Each skill can be used as a reference document or integrated into your Claude Code setup:

```bash
# Copy individual skills to your Claude Code skills directory
cp python/immutable-model-updates.md ~/.claude/skills/learned/

# Or copy entire categories
cp -r python/* ~/.claude/skills/learned/
```

### Using Skills in Claude Code

Skills are automatically available when you work with Claude Code. Reference them by name in your conversations:

```
User: "I need to update this dataclass without mutation"
Claude: [References immutable-model-updates skill]
```

---

## 🤝 Contributing

These skills were extracted from real development sessions. Contributions are welcome!

### How to Contribute

1. **Share your learned skills** - Extract patterns from your own Claude Code sessions
2. **Improve existing skills** - Add examples, clarify explanations, fix errors
3. **Add new categories** - Propose new skill categories for organization

### Skill Format

Each skill should follow this structure:

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

## Related Patterns

Links to related skills
```

---

## 📝 License

MIT License - see [LICENSE](LICENSE) file for details

---

## 🙏 Acknowledgments

- Created with [Claude Code](https://claude.ai/claude-code)
- Extracted using the continuous learning pattern
- Inspired by real-world development challenges

---

## 📖 Learn More

- [Claude Code Documentation](https://docs.anthropic.com/claude/docs/claude-code)
- [Everything Claude Code (ECC)](https://github.com/anthropics/claude-code) - Community patterns and configurations

---

**Created by:** [@shimomoto_tatsuya](https://github.com/shimomoto_tatsuya)
**Last Updated:** 2026-02-09
