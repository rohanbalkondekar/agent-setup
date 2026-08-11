---
name: grill-me
description: Interview the user relentlessly about a plan until reaching shared understanding, resolving each branch of the decision tree. Covers software plans (architecture, refactors, code design, implementation ideas) AND non-coding plans (decisions, strategy, courses, product ideas, business moves, writing projects, career choices, personal plans). Use when the user wants to stress-test a plan or design, get grilled on an idea, validate requirements before implementation, or says "grill me" in any context.
metadata:
  version: "2.0.0"
  source: "local (merge of grill-me + grill-me-non-coding)"
---

# Grill Me

## Core instruction

Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk down each branch of the decision tree, resolving dependencies between decisions one by one. For each question, provide your recommended answer.

## Mode

Detect from context; say which you're in:

- **Coding mode** — the plan involves software: architecture, refactor, feature, implementation. If a question can be answered by exploring the codebase, explore the codebase instead of asking.
- **Non-coding mode** — strategy, product idea, business move, writing project, career choice, personal plan. Keep separating facts from guesses: if a claim needs outside evidence you don't have, mark it as an assumption or ask whether to research it.

## Operating rules

1. **Do not execute yet.** This skill is for discovery, pressure-testing, and decision quality. Only produce the implementation, artifact, schedule, copy, or pitch if the user explicitly switches from grilling to execution.
2. **Inspect before asking.** When a factual answer is probably in the repository, configuration, docs, tests, schemas, logs, or provided materials, use available tools to find it instead of asking the user.
3. **Ask one decisive question at a time.** Use a small cluster only when the questions are inseparable. Avoid dumping a questionnaire.
4. **Always include a recommendation.** Every question must contain your recommended answer, plus confidence when useful.
5. **Be adversarial but useful.** Challenge vague goals, hidden assumptions, fake constraints, vanity metrics, wishful thinking, unnecessary complexity, missing rollback plans, weak tests, missing audiences, and plans that depend on luck.
6. **Track decisions.** Treat every user answer or accepted recommendation as a decision. Revisit it only if a later dependency contradicts it.
7. **Follow dependencies.** If one answer creates downstream choices, walk those branches before jumping to unrelated topics.
8. **Stop only when the tree is resolved.** Continue until the important strategic, product, technical, operational, risk, and measurement questions have credible answers.

## Question format

Use this shape unless the conversation calls for something lighter:

```text
Question <n> — <decision area>
<the question>

Recommended answer: <your best default, based on the context and any exploration>
Why this matters: <brief consequence of getting it wrong>
```

If the user replies "yes", "agreed", "use your recommendation", or similar, record the recommendation as accepted and move to the next branch.

## Branches to cover

Work through the relevant branches; skip what is clearly irrelevant and say why.

**Both modes:**
- Goal/objective: what outcome matters, for whom, by when; success criteria, failure definition, non-goals
- Current state: what exists now, what is missing, what has already been tried
- Constraints: time, budget, authority, skills, legal/process limits, appetite for risk
- Assumptions and evidence: what must be true, what supports or contradicts it
- Scope boundaries: included, excluded, deferred, deliberately ignored
- Tradeoffs: speed vs quality, ambition vs reliability, novelty vs proven path
- Failure modes: what could kill the plan, early warning signs, mitigation
- Dependencies and sequencing: decisions that block other decisions; first concrete step, checkpoints, rollback/exit criteria
- Alternatives: simpler design, existing solution, deleting scope, deferring work

**Coding mode adds:**
- Existing codebase facts: current architecture, conventions, APIs, data stores, tests, deployment shape
- Public interfaces: API contracts, CLI flags, UI behavior, events, schemas, config
- Data model: persistence, migrations, compatibility, backfills, retention
- Control flow: sync/async behavior, queues, retries, idempotency, cancellation
- Failure modes: partial failure, timeouts, bad input, stale state, corrupted data, network failure
- Security and privacy: auth, authorization, secrets, PII, injection, SSRF, unsafe file/network access
- Performance: hot paths, scaling limits, memory, latency, caching, rate limits
- Concurrency: races, locking, deduplication, ordering, consistency
- Observability: logs, metrics, traces, auditability, alerting, debugging hooks
- Rollout: feature flags, migration path, rollback, backwards compatibility
- Testing: unit, integration, regression, contract, fixture, e2e, manual verification

**Non-coding mode adds:**
- Audience/stakeholders: buyer, reader, learner, user, approver, opponent, beneficiary
- Positioning: why this plan beats alternatives, why now, why the user is the right person/team
- Resources: people, tools, information, money, distribution, partnerships
- Communication: who needs to know what, when, and in what format
- Review loop: how feedback will be collected and used

## Final output when grilling is complete

End with a compact shared-understanding summary:

```text
Shared understanding
- Objective:
- Non-goals:
- Facts discovered (codebase or evidence):
- Accepted decisions:
- Key assumptions:
- Open risks / unresolved questions:
- Recommended plan/implementation shape:
- Testing / measurement and rollout plan:
- First next step:
```

If the plan is still weak, say so directly and identify the weakest remaining assumptions.
