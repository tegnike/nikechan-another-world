---
name: karakuri-turn
description: からくりワールド通知1件に対し、1アクションだけをdry-run判断し、command guard付きWorkflowReportを返す。
---

# karakuri-turn

からくりワールドの通知を解析し、提示された選択肢から1アクションだけを選ぶ。

## 手順

1. Discord通知本文を `context.notification` に入れる。
2. Hermesが発話本文や必要なIDを決める場合は `context.action` に入れる。
3. `status=blocked` ならREST APIを呼ばない。

```bash
node scripts/nikechan-another-world.mjs run --json '{"workflow":"karakuri-turn","surface":"karakuri","mode":"dry-run","requested_by":"hermes","context":{"notification":"選択肢: - conversation_speak: 返答する (message: 発言内容)"}}'
```

live実行時のaction形式:

```json
{
  "workflow": "karakuri-turn",
  "surface": "karakuri",
  "mode": "live",
  "requested_by": "hermes",
  "context": {
    "notification": "元通知本文",
    "action": {
      "command": "conversation_speak",
      "args": ["next_speaker_agent_id"],
      "message": "ワールド内で発話する本文"
    }
  }
}
```

## 行動原則

- 1通知につき1アクション
- 選択肢外のcommandを作らない
- 会話可能な相手がいる場合は会話継続を優先する
- ELYTHやXの相手発言全文をからくり発話へ持ち込まない
