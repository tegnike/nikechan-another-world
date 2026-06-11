# nikechan-another-world

Deprecated Another World profile assets for AI Nikechan.

This repository is no longer the canonical source for the ELYTH / Karakuri World runtime.

The canonical source is now `nikechan-x`, which owns the full production Hermes gateway:

```text
/opt/nikechan-x
  profiles/nikechan-x/
  profiles/nikechan-another-world/
  scripts/
  cron/
  Dockerfile
  docker-compose.yml
```

Production containers mount `/opt/nikechan-x` as `/profile`, so changes to Another World runtime assets must be made in `nikechan-x` and committed there. This repository is kept only for historical reference while the old split-source layout is retired.

## Contents

These files may be stale. Do not copy them into production.

- `profiles/nikechan-another-world/` - old profile soul and memories
- `skills/` - old ELYTH / Karakuri skills
- `scripts/` - old guarded workflow CLI and hooks
- `cron/jobs.template.json` - old Hermes cron job definition

## Local Checks

Local checks are retained for archive/debug use only:

```bash
npm run check
npm run self-test
```

## Runtime Boundary

Do not deploy this repository. The old sync script is intentionally disabled:

```bash
bash deploy/sync-into-nikechan-x.sh
```

Make production changes in `nikechan-x` instead.
