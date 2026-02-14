#!/usr/bin/env bats

# TDD tests for scripts/migrate-format.sh
# Conversion rules from PUBLISHING-PLAN.md Section 1-2

SCRIPT="$BATS_TEST_DIRNAME/../scripts/migrate-format.sh"
FIXTURES="$BATS_TEST_DIRNAME/fixtures"

setup() {
  # Create a temporary output directory for each test
  export OUTPUT_DIR="$(mktemp -d)"
}

teardown() {
  # Clean up temporary directory
  rm -rf "$OUTPUT_DIR"
}

# --- Basic execution ---

@test "script exists and is executable" {
  [ -x "$SCRIPT" ]
}

@test "exits with error when no arguments given" {
  run bash "$SCRIPT"
  [ "$status" -ne 0 ]
}

@test "exits with error when input file does not exist" {
  run bash "$SCRIPT" --input "/nonexistent/file.md" --output-dir "$OUTPUT_DIR"
  [ "$status" -ne 0 ]
}

# --- Directory structure conversion ---
# Rule: global/python/python-immutable-accumulator.md -> skills/python-immutable-accumulator/SKILL.md

@test "creates skills/{name}/SKILL.md directory structure" {
  run bash "$SCRIPT" --input "$FIXTURES/with-frontmatter.md" --output-dir "$OUTPUT_DIR"
  [ "$status" -eq 0 ]
  [ -f "$OUTPUT_DIR/skills/python-immutable-accumulator/SKILL.md" ]
}

# --- Frontmatter conversion rules ---

@test "removes user-invocable field from frontmatter" {
  bash "$SCRIPT" --input "$FIXTURES/with-frontmatter.md" --output-dir "$OUTPUT_DIR"
  local outfile="$OUTPUT_DIR/skills/python-immutable-accumulator/SKILL.md"
  # user-invocable should NOT appear in output
  run grep -c "user-invocable" "$outfile"
  [ "$status" -ne 0 ] || [ "${lines[0]}" = "0" ]
}

@test "adds license: MIT to frontmatter" {
  bash "$SCRIPT" --input "$FIXTURES/with-frontmatter.md" --output-dir "$OUTPUT_DIR"
  local outfile="$OUTPUT_DIR/skills/python-immutable-accumulator/SKILL.md"
  run grep -c "license: MIT" "$outfile"
  [ "${lines[0]}" = "1" ]
}

@test "adds metadata.author: shimo4228" {
  bash "$SCRIPT" --input "$FIXTURES/with-frontmatter.md" --output-dir "$OUTPUT_DIR"
  local outfile="$OUTPUT_DIR/skills/python-immutable-accumulator/SKILL.md"
  run grep -c "author: shimo4228" "$outfile"
  [ "${lines[0]}" = "1" ]
}

@test "adds metadata.version: 1.0" {
  bash "$SCRIPT" --input "$FIXTURES/with-frontmatter.md" --output-dir "$OUTPUT_DIR"
  local outfile="$OUTPUT_DIR/skills/python-immutable-accumulator/SKILL.md"
  run grep -c 'version: "1.0"' "$outfile"
  [ "${lines[0]}" = "1" ]
}

@test "preserves original name field" {
  bash "$SCRIPT" --input "$FIXTURES/with-frontmatter.md" --output-dir "$OUTPUT_DIR"
  local outfile="$OUTPUT_DIR/skills/python-immutable-accumulator/SKILL.md"
  run grep -c "name: python-immutable-accumulator" "$outfile"
  [ "${lines[0]}" = "1" ]
}

@test "preserves original description field" {
  bash "$SCRIPT" --input "$FIXTURES/with-frontmatter.md" --output-dir "$OUTPUT_DIR"
  local outfile="$OUTPUT_DIR/skills/python-immutable-accumulator/SKILL.md"
  run grep "description:" "$outfile"
  [[ "$output" == *"Frozen dataclass"* ]]
}

# --- Extracted date parsing ---

@test "extracts date from Extracted line in body" {
  bash "$SCRIPT" --input "$FIXTURES/with-frontmatter.md" --output-dir "$OUTPUT_DIR"
  local outfile="$OUTPUT_DIR/skills/python-immutable-accumulator/SKILL.md"
  run grep "extracted:" "$outfile"
  [[ "$output" == *"2026-02-08"* ]]
}

@test "extracts date from bilingual Extracted format" {
  bash "$SCRIPT" --input "$FIXTURES/with-bilingual-extracted.md" --output-dir "$OUTPUT_DIR"
  local outfile="$OUTPUT_DIR/skills/bilingual-skill/SKILL.md"
  run grep "extracted:" "$outfile"
  [[ "$output" == *"2026-02-10"* ]]
}

@test "extracts first date from consolidated Extracted format" {
  bash "$SCRIPT" --input "$FIXTURES/with-consolidated-date.md" --output-dir "$OUTPUT_DIR"
  local outfile="$OUTPUT_DIR/skills/consolidated-skill/SKILL.md"
  run grep "extracted:" "$outfile"
  [[ "$output" == *"2026-02-09"* ]]
}

@test "uses current date when no Extracted line found" {
  bash "$SCRIPT" --input "$FIXTURES/no-extracted-date.md" --output-dir "$OUTPUT_DIR"
  local outfile="$OUTPUT_DIR/skills/test-no-date/SKILL.md"
  local today
  today=$(date +%Y-%m-%d)
  run grep "extracted:" "$outfile"
  [[ "$output" == *"$today"* ]]
}

# --- Files without frontmatter (derive name from filename) ---

@test "converts file without frontmatter using filename as name" {
  run bash "$SCRIPT" --input "$FIXTURES/without-frontmatter-with-context.md" --output-dir "$OUTPUT_DIR"
  [ "$status" -eq 0 ]
  [ -f "$OUTPUT_DIR/skills/without-frontmatter-with-context/SKILL.md" ]
}

@test "generates description from Context line when no frontmatter" {
  bash "$SCRIPT" --input "$FIXTURES/without-frontmatter-with-context.md" --output-dir "$OUTPUT_DIR"
  local outfile="$OUTPUT_DIR/skills/without-frontmatter-with-context/SKILL.md"
  run grep "description:" "$outfile"
  [[ "$output" == *"Refactoring a Typer"* ]]
}

@test "adds all required fields for file without frontmatter" {
  bash "$SCRIPT" --input "$FIXTURES/without-frontmatter-with-context.md" --output-dir "$OUTPUT_DIR"
  local outfile="$OUTPUT_DIR/skills/without-frontmatter-with-context/SKILL.md"
  [ "$(grep -c 'name: without-frontmatter-with-context' "$outfile")" = "1" ]
  [ "$(grep -c 'license: MIT' "$outfile")" = "1" ]
  [ "$(grep -c 'author: shimo4228' "$outfile")" = "1" ]
}

@test "preserves full body for file without frontmatter" {
  bash "$SCRIPT" --input "$FIXTURES/without-frontmatter-with-context.md" --output-dir "$OUTPUT_DIR"
  local outfile="$OUTPUT_DIR/skills/without-frontmatter-with-context/SKILL.md"
  [ "$(grep -c '# Service Layer Extraction from CLI' "$outfile")" = "1" ]
  [ "$(grep -c '## Problem' "$outfile")" = "1" ]
}

# --- Body content preservation ---

@test "preserves body content after frontmatter" {
  bash "$SCRIPT" --input "$FIXTURES/with-frontmatter.md" --output-dir "$OUTPUT_DIR"
  local outfile="$OUTPUT_DIR/skills/python-immutable-accumulator/SKILL.md"
  # Body should contain the original markdown headings
  [ "$(grep -c '# Python Immutable Accumulator' "$outfile")" = "1" ]
  [ "$(grep -c '## Problem' "$outfile")" = "1" ]
  [ "$(grep -c '## When to Use' "$outfile")" = "1" ]
}

# --- Output format validation ---

@test "output starts with --- (YAML frontmatter delimiter)" {
  bash "$SCRIPT" --input "$FIXTURES/with-frontmatter.md" --output-dir "$OUTPUT_DIR"
  local outfile="$OUTPUT_DIR/skills/python-immutable-accumulator/SKILL.md"
  local first_line
  first_line=$(head -1 "$outfile")
  [ "$first_line" = "---" ]
}

@test "frontmatter has correct structure with metadata block" {
  bash "$SCRIPT" --input "$FIXTURES/with-frontmatter.md" --output-dir "$OUTPUT_DIR"
  local outfile="$OUTPUT_DIR/skills/python-immutable-accumulator/SKILL.md"
  run grep -c "metadata:" "$outfile"
  [ "${lines[0]}" = "1" ]
}

# --- Batch mode ---

@test "batch mode: processes multiple files when given a directory" {
  local batch_input
  batch_input="$(mktemp -d)"
  cp "$FIXTURES/with-frontmatter.md" "$batch_input/"
  cp "$FIXTURES/with-bilingual-extracted.md" "$batch_input/"

  run bash "$SCRIPT" --batch "$batch_input" --output-dir "$OUTPUT_DIR"
  [ "$status" -eq 0 ]
  [ -f "$OUTPUT_DIR/skills/python-immutable-accumulator/SKILL.md" ]
  [ -f "$OUTPUT_DIR/skills/bilingual-skill/SKILL.md" ]

  rm -rf "$batch_input"
}
