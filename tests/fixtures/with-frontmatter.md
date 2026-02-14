---
name: python-immutable-accumulator
description: "Frozen dataclass + tuple accumulation pattern with slots gotcha."
user-invocable: false
---

# Python Immutable Accumulator

**Extracted:** 2026-02-08
**Context:** frozen dataclass + tupleで安全な状態蓄積を実現するパターン

---

## Problem

Mutableな状態蓄積はバグの温床。

## When to Use

- コスト追跡、ログ蓄積
