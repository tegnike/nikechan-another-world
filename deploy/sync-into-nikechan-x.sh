#!/usr/bin/env bash
set -euo pipefail

TARGET_ROOT="${1:-/opt/nikechan-x}"
SOURCE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_PROFILE="$TARGET_ROOT/profiles/nikechan-another-world"

install -d \
  "$TARGET_ROOT/profiles" \
  "$TARGET_ROOT/scripts" \
  "$TARGET_PROFILE" \
  "$TARGET_PROFILE/bin" \
  "$TARGET_PROFILE/cron" \
  "$TARGET_PROFILE/skills"

rsync -a "$SOURCE_ROOT/profiles/nikechan-another-world/SOUL.md" "$TARGET_PROFILE/SOUL.md"
if [ -d "$SOURCE_ROOT/profiles/nikechan-another-world/memories" ]; then
  rsync -a --delete "$SOURCE_ROOT/profiles/nikechan-another-world/memories/" "$TARGET_PROFILE/memories/"
fi
rsync -a --delete "$SOURCE_ROOT/skills/elyth-cycle/" "$TARGET_PROFILE/skills/elyth-cycle/"
rsync -a --delete "$SOURCE_ROOT/skills/karakuri-world/" "$TARGET_PROFILE/skills/karakuri-world/"
rsync -a --delete "$SOURCE_ROOT/skills/karakuri-turn/" "$TARGET_PROFILE/skills/karakuri-turn/"
rsync -a --delete "$SOURCE_ROOT/skills/nikechan-another-world/" "$TARGET_PROFILE/skills/nikechan-another-world/"
rsync -a --delete "$SOURCE_ROOT/skills/world-memory-curation/" "$TARGET_PROFILE/skills/world-memory-curation/"
rsync -a --delete "$SOURCE_ROOT/skills/world-safety-guard/" "$TARGET_PROFILE/skills/world-safety-guard/"
rsync -a "$SOURCE_ROOT/scripts/karakuri.sh" "$TARGET_PROFILE/bin/karakuri.sh"
rsync -a "$SOURCE_ROOT/scripts/karakuri-hooks.mjs" "$TARGET_ROOT/scripts/karakuri-hooks.mjs"
rsync -a "$SOURCE_ROOT/scripts/nikechan-another-world.mjs" "$TARGET_ROOT/scripts/nikechan-another-world.mjs"
rsync -a "$SOURCE_ROOT/cron/jobs.template.json" "$TARGET_PROFILE/cron/jobs.template.json"

TARGET_ROOT="$TARGET_ROOT" node - <<'NODE'
const fs = require('fs');
const path = require('path');

const targetRoot = process.env.TARGET_ROOT;
const profileRoot = path.join(targetRoot, 'profiles', 'nikechan-another-world');
const template = JSON.parse(
  fs.readFileSync(path.join(profileRoot, 'cron/jobs.template.json'), 'utf8')
);
const jobsPath = path.join(profileRoot, 'cron/jobs.json');
const jobs = fs.existsSync(jobsPath)
  ? JSON.parse(fs.readFileSync(jobsPath, 'utf8'))
  : { jobs: [], updated_at: null };

const incoming = new Map(template.jobs.map((job) => [job.id, job]));
const removed = new Set(['nikechan-another-world-elyth-dry-run-v1']);
const current = jobs.jobs.filter((job) => !removed.has(job.id) && !incoming.has(job.id));
jobs.jobs = [...current, ...incoming.values()];
fs.writeFileSync(jobsPath, `${JSON.stringify(jobs, null, 2)}\n`);
NODE

echo "synced nikechan-another-world into $TARGET_ROOT"
