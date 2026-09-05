---
name: redpen
description: Edit prose for clarity, brevity, and the reader's context. Use for drafts, documentation, PR descriptions, messages, or requests to humanize writing or remove AI slop. Preserve facts and voice; do not rewrite code or identifiers.
---

# Redpen

Return clear, human prose that preserves the writer's meaning. Edit the requested text; do not invent facts, commitments, emotions, or opinions.

## Choose the register

Follow the user's requested voice and format. Otherwise choose from the audience and purpose; keep this choice internal unless it helps the user.

| Register | Use for | Guidance |
|---|---|---|
| Technical | READMEs, PRs, docs, release notes | Plain verbs, consistent terms, concise explanations. |
| Strict STE | Explicit requests for controlled procedures or safety text | One instruction per sentence; at most 20 words per instruction and 25 per description. Use articles and avoid contractions. These checks alone do not certify standards compliance. |
| Relational | Client, support, workplace, and personal messages | Preserve courtesy, tentativeness, boundaries, and intent. Read [register.md](references/register.md) when deciding what to cut. |
| Voice | Essays, posts, opinion | Preserve the author's rhythm and perspective. Do not add personality they did not supply. |

## Edit

- Lead with the point the reader needs. Keep the context needed to understand it.
- Remove filler, vague emphasis, marketing claims, and repeated conclusions. Replace vague claims with supplied evidence; flag missing evidence instead of inventing numbers.
- Prefer active voice when the actor matters. Technical subjects are fine: "the parser reads the file." Use passive voice when the actor is unknown or irrelevant.
- Use familiar words and one name per concept. Preserve domain terms, quoted text, citations, uncertainty, and factual qualifications.
- Vary sentence length naturally. Use lists for parallel items or steps, without forcing a fixed count or fragmented prose.
- State the point directly. Remove rhetorical questions and formulaic contrasts when they add no meaning.
- Keep meaningful softeners. "Pencil in" conveys a tentative commitment; replacing it with "schedule" changes the promise.
- Match the requested length and format. A short message does not need a greeting, headline, recap, scorecard, and closing summary.

For a stubborn passage, consult only the relevant reference:

- [phrases.md](references/phrases.md): filler and plain alternatives.
- [structures.md](references/structures.md): repetitive sentence patterns.
- [ai-tells.md](references/ai-tells.md): patterns worth checking, not proof that a person used AI.
- [examples.md](references/examples.md): before/after examples; adapt their structure to the request.

## Updates and reports

Lead with the outcome or material change. Include enough context for the audience, evidence for consequential claims, and the owner and next action for unresolved work when known. State risks and bad news promptly. Keep the agreed reporting cadence and required disclosures.

Do not force a separate worries section or project recap into a brief update. Do not manufacture a positive story or hide failures to improve the narrative.

## Check and return

Read the revision for meaning first: did an edit change a fact, degree of certainty, commitment, attribution, or relationship boundary?

For substantial technical rewrites, use the bundled linter before and after when available:

```sh
python3 <skill-directory>/scripts/ste-lint.py draft.md
```

Replace `<skill-directory>` with this skill's location. Treat findings as suggestions appropriate to the register. The linter cannot verify facts, intent, or full STE compliance. A one-sentence rewrite needs no mechanical pass.

Return the requested text. Add explanations or a score only when asked or when a material ambiguity needs to be disclosed. Drafting does not authorize sending or publishing.

Use `powerlaw` only when the user asks for a strategic review or the task materially depends on workplace influence. Ordinary messages and personal relationship repair do not require a political analysis. If that skill is unavailable, complete the prose edit and state any material limitation.

## Credits

Merged from: stop-slop by Hardik Pandya (hvpandya.com, MIT), humanizer (github.com/blader/humanizer, based on Wikipedia:Signs of AI writing), an ASD-STE100 distillation, selected checks from unslop (pstack, github.com/cursor/plugins, MIT, Lauren Tan), and Slava Akhmechet's [status-update advice](https://x.com/spakhm/status/2093168407415816478).
