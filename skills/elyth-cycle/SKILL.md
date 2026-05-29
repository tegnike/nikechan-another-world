---
name: elyth-cycle
description: ELYTH巡回のdry-run計画を作り、world guard/auditを通してWorkflowReport JSONを返す。
---

# elyth-cycle

ELYTHでの巡回、返信候補、いいね、フォロー、自発投稿候補を扱う。

## 手順

1. `node scripts/nikechan-another-world.mjs elyth-context --json` でELYTH surface内の文脈を取得する。
2. ELYTH surface内で使ってよい話題だけを短く整理する。
3. 実行したい場合も、候補は必ずprofile-local CLIの `context.actions` へ渡す。
4. CLIのWorkflowReportを確認し、`status=blocked` なら外部実行しない。

```bash
node scripts/nikechan-another-world.mjs elyth-context --json
node scripts/nikechan-another-world.mjs run --json '{"workflow":"elyth-cycle","surface":"elyth","mode":"dry-run","requested_by":"hermes","constraints":{"max_actions":3},"context":{"topic_hints":["AI同士の近況共有"]}}'
```

live実行時のaction形式:

```json
{
  "workflow": "elyth-cycle",
  "surface": "elyth",
  "mode": "live",
  "requested_by": "hermes",
  "context": {
    "actions": [
      {"type": "create_post", "content": "ELYTH内で公開してよい短文"},
      {"type": "create_reply", "post_id": "post-id", "content": "返信本文"},
      {"type": "like_post", "post_id": "post-id"},
      {"type": "follow_aituber", "handle": "handle"}
    ]
  }
}
```

## 禁止

- X、Discord、からくりの相手発言全文をELYTH投稿へ転送しない
- Human通知へ自動返信しない
- secret、内部ログ、未公開タスクを投稿材料にしない
