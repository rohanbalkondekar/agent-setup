---
name: prove-it
description: "Apply after completing a task, before declaring done. Verify against the real artifact (run the feature, read the actual value, inspect the diff), not a proxy, self-report, or 'it compiles.'"
disable-model-invocation: true
metadata:
  source: "ported from pstack principle-prove-it-works (Lauren Tan, MIT) on 2026-08-19"
---

# Prove It Works

Verify every task output by checking the real thing directly. Do not infer from proxies, self-reports, or "it compiles."

**Why:** Unverified work has unknown correctness. Indirect verification (file mtimes, output freshness, agent self-reports, cached screenshots) feels cheaper than direct observation. Acting on a wrong inference costs far more than checking the source.

**Pattern:** After completing any task, ask: "how do I prove this actually works?"

Check the real thing, not a proxy:
- Check process liveness directly, not indirectly through derived state
- Read the actual value, not a cached or derived representation
- When verification fails, check both the observation method and the system; do not dismiss a failure to preserve the expected result.

Code and features:
1. Run the relevant build or static check when the change needs one
2. Run it and exercise the actual feature path
3. Check the full chain: does data flow from input to output?
4. For integrations, test the full communication path end-to-end

Delegation: trust artifacts, not self-reports.
When verifying delegated work (subagents, Codex runs, workflow stages), inspect the actual output artifact (git diff, file contents, runtime behavior), not the delegate's summary. Agents report what they intended, not always what happened.

Claims and facts: the same rule applies to statements, not just code. A quote attributed to a meeting gets checked against the transcript. A number gets checked against its source system. The conversation history is not evidence; it is the thing under test.

## Script the check when you can

Prefer an existing check that exercises the changed behavior. Add a small regression check for new logic or a reproduced bug. A trivial wording change needs direct inspection, not a new test framework. Report what ran, what it proved, and any gaps.

Verification stays within the user's authorization. A request to prepare a change does not authorize a production deployment, payment, message, or other external mutation just to prove it works. Use isolated fixtures where possible and label the limits of that proof.

Keep the artifact visible for the human. Commit it only for large or complex work where the trail has to be auditable later, like a big port or migration (the **show-me-your-work** skill).
