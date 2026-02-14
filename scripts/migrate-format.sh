#!/usr/bin/env bash
set -euo pipefail

# migrate-format.sh
# Converts learned skill .md files to Agent Skills standard (skills/*/SKILL.md)
# See: docs/PUBLISHING-PLAN.md Section 1-2

usage() {
  echo "Usage:"
  echo "  $(basename "$0") --input <file.md> --output-dir <dir>"
  echo "  $(basename "$0") --batch <dir-of-md-files> --output-dir <dir>"
  exit 1
}

# Extract description from Context line in body (for files without frontmatter)
extract_description_from_body() {
  local body="$1"
  local ctx
  ctx=$(echo "$body" | grep -oE '\*\*Context[^*]*\*\*:?[[:space:]]*(.+)' | sed 's/\*\*Context[^*]*\*\*:*[[:space:]]*//' | head -1 || true)
  if [ -n "$ctx" ]; then
    echo "\"$ctx\""
  else
    echo "\"TODO: Add description\""
  fi
}

# Parse a YYYY-MM-DD date from the body text's "Extracted" line
# Supports: "**Extracted:** 2026-02-08" and "**Extracted / 抽出日:** 2026-02-08"
extract_date_from_body() {
  local body="$1"
  local date_match
  date_match=$(echo "$body" | grep -oE '\*\*Extracted[^*]*\*\*:?[[:space:]]*[0-9]{4}-[0-9]{2}-[0-9]{2}' | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' | head -1 || true)
  if [ -n "$date_match" ]; then
    echo "$date_match"
  else
    date +%Y-%m-%d
  fi
}

# Convert a single file
convert_file() {
  local input_file="$1"
  local output_dir="$2"

  if [ ! -f "$input_file" ]; then
    echo "Error: Input file not found: $input_file" >&2
    exit 1
  fi

  local content
  content=$(cat "$input_file")

  local name description body
  local first_line
  first_line=$(echo "$content" | head -1)

  if [ "$first_line" = "---" ]; then
    # --- File WITH frontmatter ---
    local fm_end
    fm_end=$(echo "$content" | tail -n +2 | grep -n '^---$' | head -1 | cut -d: -f1)
    if [ -z "$fm_end" ]; then
      echo "Error: Unterminated frontmatter in $input_file" >&2
      return 1
    fi

    local frontmatter
    frontmatter=$(echo "$content" | sed -n "2,$((fm_end))p")
    body=$(echo "$content" | tail -n +"$((fm_end + 2))")

    name=$(echo "$frontmatter" | grep '^name:' | sed 's/^name:[[:space:]]*//' | tr -d '"' | tr -d "'")
    description=$(echo "$frontmatter" | grep '^description:' | sed 's/^description:[[:space:]]*//')

    if [ -z "$name" ]; then
      echo "Error: No 'name' field in frontmatter of $input_file" >&2
      return 1
    fi
  else
    # --- File WITHOUT frontmatter ---
    # Derive name from filename, description from Context line
    name=$(basename "$input_file" .md)
    body="$content"
    description=$(extract_description_from_body "$body")
  fi

  # Extract date from body
  local extracted_date
  extracted_date=$(extract_date_from_body "$body")

  # Create output directory
  local skill_dir="$output_dir/skills/$name"
  mkdir -p "$skill_dir"

  # Write new SKILL.md with converted frontmatter
  {
    echo "---"
    echo "name: $name"
    echo "description: $description"
    echo "license: MIT"
    echo "metadata:"
    echo "  author: shimo4228"
    echo '  version: "1.0"'
    echo "  extracted: \"$extracted_date\""
    echo "---"
    echo "$body"
  } > "$skill_dir/SKILL.md"

  echo "Converted: $input_file -> $skill_dir/SKILL.md"
}

# Main
if [ $# -eq 0 ]; then
  usage
fi

INPUT_FILE=""
BATCH_DIR=""
OUTPUT_DIR=""

while [ $# -gt 0 ]; do
  case "$1" in
    --input)
      INPUT_FILE="$2"
      shift 2
      ;;
    --batch)
      BATCH_DIR="$2"
      shift 2
      ;;
    --output-dir)
      OUTPUT_DIR="$2"
      shift 2
      ;;
    *)
      echo "Error: Unknown option: $1" >&2
      usage
      ;;
  esac
done

if [ -z "$OUTPUT_DIR" ]; then
  echo "Error: --output-dir is required" >&2
  usage
fi

if [ -n "$INPUT_FILE" ]; then
  convert_file "$INPUT_FILE" "$OUTPUT_DIR"
elif [ -n "$BATCH_DIR" ]; then
  if [ ! -d "$BATCH_DIR" ]; then
    echo "Error: Batch directory not found: $BATCH_DIR" >&2
    exit 1
  fi
  found=0
  errors=0
  for file in "$BATCH_DIR"/*.md; do
    [ -f "$file" ] || continue
    if convert_file "$file" "$OUTPUT_DIR"; then
      found=$((found + 1))
    else
      errors=$((errors + 1))
    fi
  done
  if [ "$found" -eq 0 ] && [ "$errors" -eq 0 ]; then
    echo "Error: No .md files found in $BATCH_DIR" >&2
    exit 1
  fi
  if [ "$errors" -gt 0 ]; then
    echo "Warning: $errors file(s) skipped due to errors" >&2
  fi
  echo "Batch complete: $found converted, $errors skipped"
else
  echo "Error: Either --input or --batch is required" >&2
  usage
fi
