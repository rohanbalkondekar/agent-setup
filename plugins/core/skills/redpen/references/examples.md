# Before/After Examples

These examples explain editing choices. In coaching mode, quote the issue and explain a possible fix; leave the revision to the writer. Return a full "After" version only when a rewrite is explicitly requested. Do not add facts or change the writer's certainty.

## Coaching: empty adjectives and adverbs

**Draft:** "We made a really impressive improvement to the setup process."

**Feedback:** "Really" adds emphasis without information. "Impressive" adds praise without explaining the change. Cut both and name what improved. Keep a modifier such as "partial" if it describes the actual result.

## Coaching: vocabulary in context

**Draft:** "This is the date we have in mind, but it is not confirmed."

**Feedback:** Your wording is clear. An optional shorter phrase is "tentative date." "Tentative" means proposed but not confirmed. It fits a workplace update and preserves the uncertainty. Do not use "scheduled" if the date is still undecided.

## Example 1: Throat-Clearing + Binary Contrast

**Before:**
> "Here's the thing: building products is hard. Not because the technology is complex. Because people are complex. Let that sink in."

**After:**
> "Building products is hard because people are complex."

**Changes:** Removed the opener, rhetorical setup, and emphasis crutch. Kept the stated reason without adding a claim about whether technology or people are manageable.

---

## Example 2: Filler + Unnecessary Reassurance

**Before:**
> "It turns out that most teams struggle with alignment. The uncomfortable truth is that nobody wants to admit they're confused. And that's okay."

**After:**
> "Most teams struggle with alignment. Nobody wants to admit they're confused."

**Changes:** Removed the opener and emphasis. Kept "most" because it limits the claim. Kept the distinction between reluctance to admit confusion and whether people actually admit it.

---

## Example 3: Business Jargon Stack

**Before:**
> "In today's fast-paced landscape, we need to lean into discomfort and navigate uncertainty with clarity. This matters because your competition isn't waiting."

**Feedback:** What action should the team take? Replace "lean into discomfort" and "navigate uncertainty with clarity" with that action. The draft does not establish that the intended action is to move faster.

---

## Example 4: Dramatic Fragmentation

**Before:**
> "Speed. Quality. Cost. You can only pick two. That's it. That's the tradeoff."

**After:**
> "Speed, quality, cost: pick two."

**Changes:** Single sentence. No performative emphasis. No em dash.

---

## Example 5: Rhetorical Setup

**Before:**
> "What if I told you that the best teams don't optimize for productivity? Here's what I mean: they optimize for learning. Think about it."

**After:**
> "The best teams optimize for learning, not productivity."

**Changes:** Direct claim. No rhetorical scaffolding.

---

## Example 6: Register (What NOT to Strip)

**Original (assistant to a client):**
> "Your meeting has been arranged at his residence at 5 pm. May I pencil in a follow-up at 2 pm Thursday? And for the dinner, what is your meal preference?"

**Over-corrected (core rules applied blindly):**
> "Meeting: his house, 5 pm. I blocked Thursday 2 pm. Veg or non-veg?"

**Correct:** Keep the original. Every "violation" carries intent: "residence" signals regard, "pencil in" keeps the slot tentative and the reader in control, the open question invites a real answer. This is register, not slop. See [register.md](register.md).

---

## Example 7: Chat Messages — Split Lines, Not Blocks

In chat (Slack, Teams, DMs), the reader scans on a phone between meetings. Line breaks are punctuation there: each line is one fact the reader can absorb or skip. A message that would be one paragraph in an email becomes several short lines in chat.

**Before (one dense block):**
> "Hey Maya! Quick update on the intern program: 16 are confirmed for Berlin and 10 for Madrid (6 in the north office + 4 in the south), so 26 total, and this number will increase as more people accept their offers; I've also messaged Tomas for the final numbers and will update you once he replies."

**After (split for the reader):**
> Hey Maya!
>
> Update on the intern program:
>
> 16 - confirmed for Berlin
> 10 - confirmed for Madrid (north 6 + south 4)
>
> Total: 26 (will grow as more offers are accepted)
>
> I have messaged Tomas for the final numbers, will update you once he replies.

**Changes:** Same words, different shape. The pattern:

- Greeting on its own line, blank line after it.
- One idea per line; blank line between topics.
- Numbers and statuses as labeled lines, never buried in prose.
- Close with the current status plus the next action ("I have messaged X, will update you once he replies") so the reader knows what happens without asking.
- New paragraph whenever the reader could stop reading and still act.

This is a formatting register, orthogonal to word choice: the relational rules from [register.md](register.md) still decide the words, this decides the shape. Do not apply it to essays or docs — there, paragraphs carry the argument and chopping them into single lines reads as dramatic fragmentation (see [structures.md](structures.md)).

---

## Example 8: Verdict First

The reader's first question is "so what?" Answer it in the first two lines, then give the supporting detail. This applies to emails, reviews, updates, and decision documents alike.

**Before (verdict buried):**
> Hi Dana,
>
> I went through the submission today. The architecture is clean, the provider design is sensible, the cross-cutting behaviors (chunking, caching, idempotency) are all verified in the write-up, and the candidate documented an AI suggestion they rejected with good reasoning. Overall the code quality is above what we usually see at this stage, so considering everything I think we should probably move forward with an interview.

**After (verdict first):**
> Hi Dana,
>
> I finished the technical review of the submission today.
>
> Bottom line: this is a strong submission, and I recommend we move to the interview.

**Changes:** The recommendation moved from the last clause to its own labeled line near the top. Detail can follow for readers who want it — but the decision no longer depends on reading that far. In a decision document, the same pattern is a TL;DR/Decision section at the top, before scope, options, or analysis.

---

## Example 9: State the Negative Space

Strong plans and decisions spend words on what they do NOT cover. Without an explicit out-of-scope list, every reader fills the silence with their own assumption, and each one fills it differently.

**Before (scope only):**
> Phase 1 delivers isolated QA environments for the pilot team, a database snapshot strategy, and the tech stack decision.

**After (only if the writer supplied these scope boundaries):**
> Phase 1 delivers isolated QA environments for the pilot team, a database snapshot strategy, and the tech stack decision.
>
> Out of scope for Phase 1: developer environments (Phase 2), self-serve onboarding (Phase 2), and full replacement of shared staging.
>
> Done does not require: every team onboarded, zero shared-staging usage, or agents running unattended.

**Changes:** Two lists most writers skip. "Out of scope" kills scope creep before it starts; "does not require" stops the definition of done from inflating in reviewers' heads. The pattern generalizes: an ADR states what it does NOT decide, a proposal states what the budget does NOT include. Ask for missing scope boundaries; do not invent phase assignments or exclusions.

---

## Example 10: Claims Carry Evidence, Open Items Carry Owners

Two completeness checks for status updates, digests, and reports.

**Before:**
> The review agent is saving significant time and the docs integration is much faster. We are also working on the licensing question.

**After (structure only; fill from facts supplied by the writer):**
> The review agent saves [measured time] per merge request ([source and sample]). Docs integration takes [measured duration], down from [previous duration] ([source]).
>
> Licensing: [owner] is waiting on [needed answer] from [party]. Next action: [action and date, if known].

**Changes:** "Significant" and "much faster" need evidence. Use measurements and sources supplied by the writer, or qualify the claims to match what was observed. Name the owner and next action when known. Flag missing details; do not invent them or treat placeholders as finished text.
