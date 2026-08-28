---
name: redpen
description: Check and rewrite prose to remove AI slop and make writing clear, human, and fit for its reader. Merges stop-slop (AI-pattern removal), ASD-STE100 Simplified Technical English (controlled style for docs/procedures), and humanizer (AI-tells catalog + voice). Use when drafting, editing, or reviewing any prose — docs, READMEs, PR descriptions, release notes, error messages, emails, Slack messages, essays, posts — or when asked to "redpen", "check my writing", "make this not sound like AI", "humanize", "de-slop", or enforce plain/controlled technical style. Never applies to code. If the text is a stakeholder or workplace communication with political stakes, this skill also triggers the powerlaw skill (power-check mode).
---

# Redpen — writing check

Check writing like an editor with a red pen: mark what's wrong, fix it, return clean text. This applies to prose only — never code, identifiers, or command syntax.

## The four principles (Zinsser, *On Writing Well*)

Every rule below serves one of these. When a rule and a principle conflict, the principle wins.

1. **Simplicity** — strip every sentence to its cleanest components. One idea per sentence, the plain word, no clutter.
2. **Brevity** — the shortest version that still does the job. Every word that can go, goes.
3. **Clarity** — the reader must never have to read a sentence twice. If it can be misread, it will be.
4. **Humanity** — a real person is talking. Warmth, voice, and the relational register are not decoration; text that is clean, direct, and cold has failed this principle (see rule 9 and [references/register.md](references/register.md)).

Pipeline: **pick the register → apply the rules → run the quick checks → lint mechanically → score → hand off to powerlaw if political**.

## Step 1 — pick the register (say which)

| Register | For | Discipline |
|---|---|---|
| **strict STE** | procedures, runbooks, safety text, error messages | every STE rule + both length caps |
| **STE-flavored** | READMEs, PR descriptions, docs, release notes | STE sentence/paragraph/active-voice/plain-verb discipline; relax the ~900-word dictionary lockdown so text reads naturally |
| **relational** | client messages, executive comms, hospitality, support | core rules, but keep words that carry intent — see rule 9 and [references/register.md](references/register.md) |
| **voice** | essays, posts, opinion, personal writing | core rules + the Voice section — slop removal alone leaves text sterile |

## Step 2 — core rules (all registers)

1. **Cut filler phrases.** Remove throat-clearing openers and emphasis crutches. Cut adverbs, or replace the verb+adverb with a stronger verb or the measured number ("runs quickly" → "is fast" or the benchmark; "significantly improves" → the delta). An adverb propping up a weak verb means the verb is wrong. See [references/phrases.md](references/phrases.md).
2. **Break formulaic structures.** Avoid binary contrasts, negative listings, dramatic fragmentation, rhetorical setups, false agency. See [references/structures.md](references/structures.md).
3. **Use active voice.** Every sentence needs a human subject doing something. No inanimate objects performing human actions ("the complaint becomes a fix").
4. **Be specific.** No vague declaratives ("The reasons are structural"). Name the specific thing. No lazy extremes ("every," "always," "never") doing vague work.
5. **Put the reader in the room.** No narrator-from-a-distance voice. "You" beats "People." Specifics beat abstractions.
6. **Vary rhythm.** Mix sentence lengths. Two items beat three. End paragraphs differently. No em dashes.
7. **Trust readers.** State facts directly. Skip softening, justification, hand-holding.
8. **Cut quotables.** If it sounds like a pull-quote, rewrite it.
9. **Match the register.** Slop is words that carry no intent, not words that are long or formal. Before cutting a softener or "fancy" word in outward-facing, relational text, test: does it carry intent the plain word doesn't? "Pencil in" signals tentativeness; "utilize" signals nothing. See [references/register.md](references/register.md).
10. **Know the AI tells.** The full pattern catalog (significance inflation, -ing analyses, vague attributions, synonym cycling, false ranges, rule-of-three, copula avoidance, and more) is in [references/ai-tells.md](references/ai-tells.md) — consult it when reviewing suspect text or when a rewrite still smells generated.

## Step 3 — ASD-STE100 Simplified Technical English rules (strict and STE-flavored registers)

WORDS
- Use one name for one thing. Do not call the same item by two different names.
- Use the short common word: start (not begin/commence/initiate), use (not utilize/leverage), help (not facilitate), make sure (not ensure), before (not prior to), after (not subsequent to), about (not regarding/concerning), get (not obtain/acquire), show (not demonstrate), also (not additionally/furthermore/moreover).
- Give each word one meaning. "fall" means to move down, not to decrease.
- No marketing adjectives: seamless, robust, powerful, cutting-edge, effortless, world-class, next-generation, revolutionary.
- American spelling.

VERBS
- Active voice. "the parser reads the file", not "the file is read by the parser".
- Use a verb for an action. "analyze the log", not "perform an analysis of the log".
- No stacked auxiliaries. Not "it is important to note that this may help to improve". Write "this improves X".
- No "-ing" main verb where a simple tense works.

SENTENCES
- One instruction per sentence. Max 20 words (instruction), max 25 (descriptive).
- No contractions in strict mode. Use articles: a, an, the, this, these.

PUNCTUATION
- No semicolons. Write two sentences. (STE does not ban the em dash — the core rules do.)

STRUCTURE
- One topic per paragraph, max six sentences. For steps, use a numbered vertical list, one action per item, imperative form. Put a condition before its command.

Write only the requested text. No preamble, no summary, no closing remarks.

Free official standard (do not paste it in full; it is copyrighted): https://asd-ste100.org

## Step 4 — voice (voice register)

Avoiding AI patterns is only half the job. Sterile, voiceless writing is just as obvious as slop. Signs of soulless writing even when technically "clean": every sentence the same length, no opinions, no acknowledged uncertainty, no first person where it fits, no humor or edge — reads like a press release.

- **Have opinions.** Don't just report facts — react to them. "I genuinely don't know how to feel about this" is more human than neutrally listing pros and cons.
- **Vary your rhythm.** Short punchy sentences. Then longer ones that take their time getting where they're going.
- **Acknowledge complexity.** "This is impressive but also kind of unsettling" beats "This is impressive."
- **Use "I" when it fits.** First person isn't unprofessional; it signals a real person thinking.
- **Let some mess in.** Tangents and asides are human. Perfect structure feels algorithmic.
- **Be specific about feelings.** Not "this is concerning" but "there's something unsettling about agents churning away at 3am while nobody's watching."

## Stakeholder updates and reports

For project, investor, executive, or cross-team updates, edit for stewardship, not activity reporting:

1. Open with a one-sentence headline. Follow with a 2–4 sentence recap of the project's goal.
2. Assume the audience is smart, busy, and missing context. Answer the three questions they care about most.
3. Show evidence that the writer is fulfilling the entrusted role. Do not substitute a list of completed tasks.
4. State material changes from the prior update and explain why they changed.
5. Use a calm, factual tone. Keep the focus on the work. Remove blame, insults, self-defense, and over-sanitized corporate language.
6. Add a distinct worries-and-failures section. State each concern honestly with its plan, owner, and next action.
7. Surface possible bad news early and confirm it when known. Never delay urgent or required disclosure to improve the narrative.
8. If cadence is optional, prefer a real headline within a bounded window over empty scheduled mail. Keep any required or agreed reporting schedule.

Plan the next update's likely headline before the reporting date. Create pleasant surprises through real delivery, never through hidden work or lowered expectations.

## Step 5 — quick checks (before delivering)

- Any adverbs? Cut, or swap in a stronger verb or the number.
- Any passive voice? Find the actor, make them the subject.
- Inanimate thing doing a human verb ("the decision emerges")? Name the person.
- Sentence starts with a Wh- word? Restructure it.
- Any "here's what/this/that" throat-clearing? Cut to the point.
- Any "not X, it's Y" contrasts? State Y directly.
- Three consecutive sentences match length? Break one.
- Paragraph ends with punchy one-liner? Vary it.
- Em-dash anywhere? Remove it.
- Sentence over 20 words (STE registers)? Split it.
- Semicolon (STE registers)? Two sentences.
- Nominalization ("perform an analysis") or phrasal verb ("spin up")? Plain verb.
- Same thing named two ways? Pick one name.
- Vague declarative ("The implications are significant")? Name the specific implication.
- Meta-joiners ("The rest of this essay...")? Delete. Let the essay move.
- Outward-facing relational text? Before stripping a courtesy or softener, run the intent test in [references/register.md](references/register.md). "Wait." is not an improvement on "Allow me a moment" when a client is reading.
- Chat message (Slack, Teams, DM)? Split it: greeting on its own line, one idea per line, blank line between topics, numbers as labeled lines, close with status + next action. See example 7 in [references/examples.md](references/examples.md). (Chat only — in essays and docs this becomes dramatic fragmentation.)
- Email, review, update, or decision doc? Verdict in the first two lines ("Bottom line: ..." / a TL;DR section), detail after. See example 8.
- Plan, proposal, or ADR? State the negative space: an out-of-scope list and a "done does not require" list. See example 9.
- Status update or report? Every claim carries a number or a link; every open item carries an owner and a next action. See example 10.
- Colon as a mid-sentence connector (not before a list or example)? Rewrite so the point stands alone.
- Abstract metaphor noun (substrate, wedge, vector, nexus, locus, vantage, bedrock, modality, paradigm, primitive-as-noun, harness/surface/scaffolding as metaphor, gold-plating, ratchet, evacuate-for-code, endgame, north star, flywheel)? Use the concrete word: "substrate" → "base", "wedge in" → "add", "gold-plating" → "more than the job needs", "endgame" → "the last phase".
- Hyphen or en dash doing an em dash's job ("smooth - its just...")? Same tell, same fix: period or comma.
- Can't restate the sentence as a concrete instruction, fact, or number? Cut it.
- Could the sentence appear unchanged in another project's docs? Then it says nothing about this one. Cut it.
- Bold inline header that restates its line ("**Performance:** Performance improved...")? Convert to prose. A bold lead-in that ends in a period and is followed by genuinely new detail is fine.
- Last pass: ask "what makes this obviously AI generated?" and fix what you find.

## Step 6 — mechanical lint

Deterministic second opinion (script lives in this skill's directory):

```
python3 scripts/ste-lint.py draft.md    # or pipe text on stdin
```

Score is violations per 100 words; lower is cleaner. Lint before and after a rewrite — the delta is the signal. It catches long sentences, passive voice, nominalizations, banned words, and em dashes a rewrite missed. It also flags contractions and softeners, which the relational and voice registers permit — read its output through rule 9.

The mechanical rules are what removes slop's FORM. A checker cannot certify substance — this skill cannot make a hollow paragraph true.

## Step 7 — score

Rate 1–10 on each dimension; below 42/60, revise. (Directness and Density serve Simplicity and Brevity; Trust serves Clarity; Authenticity and Register serve Humanity.)

| Dimension | Question |
|-----------|----------|
| Directness | Statements or announcements? |
| Rhythm | Varied or metronomic? |
| Trust | Respects reader intelligence? |
| Authenticity | Sounds human? |
| Density | Anything cuttable? |
| Register | Word choice matched to reader and stakes? |

## Step 8 — powerlaw hand-off

If the text is a stakeholder communication, workplace message, negotiation, escalation, or anything with political stakes: after the style pass, **invoke the `powerlaw` skill (power-check mode)** on the revised draft. Redpen fixes how it reads; powerlaw checks whether it's the right move, to the right person, at the right time. Deliver both results together — style rewrite first, power check after.

## Examples and credits

Before/after transformations: [references/examples.md](references/examples.md). Full AI-tells catalog with examples: [references/ai-tells.md](references/ai-tells.md).

Merged from: stop-slop by Hardik Pandya (hvpandya.com, MIT), humanizer (github.com/blader/humanizer, based on Wikipedia:Signs of AI writing), an ASD-STE100 distillation, selected checks from unslop (pstack, github.com/cursor/plugins, MIT, Lauren Tan), and Slava Akhmechet's [status-update advice](https://x.com/spakhm/status/2093168407415816478).
