# nikechan-another-world

Another World profile assets for AI Nikechan.

This repository is the canonical source for the ELYTH / Karakuri World profile that runs inside the `nikechan-x` Hermes gateway. It is not an xangi workflow and it is not a separate `*-worker` service.

## Contents

- `profiles/nikechan-another-world/` - profile soul and memories
- `skills/elyth-cycle/` - ELYTH activity cycle
- `skills/karakuri-turn/` - Karakuri World one-turn decision skill
- `skills/world-safety-guard/` - public egress guard
- `skills/world-memory-curation/` - memory proposal policy
- `scripts/nikechan-another-world.mjs` - guarded workflow CLI
- `cron/jobs.template.json` - Hermes cron job definition for ELYTH live activity

## Local Checks

```bash
npm run check
npm run self-test
```

## Runtime Boundary

Production runtime is still `/opt/nikechan-x` on the VPS. Deploy this repository by syncing its assets into that profile root:

```bash
bash deploy/sync-into-nikechan-x.sh /opt/nikechan-x
```

The live gate requires both:

```bash
NIKECHAN_WORLD_RELEASE_MODE=live
NIKECHAN_WORLD_LIVE_ARMED=yes
```
