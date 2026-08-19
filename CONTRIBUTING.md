# Contributing

This is a Claude Code skill: two Markdown files (`skills/a11y-audit/categories.md`
and `skills/a11y-audit/a11y-audit.md`) that instruct the model how to run a
WCAG 2.2 AA completeness audit. There's no code, no scripts, no
dependencies — contributions are welcome, but the review bar is "does this
actually generalize," not "does this pass tests."

## Ground rules

- **`categories.md` stays generic, forever.** No hardcoded file paths, no
  framework-specific implementation details as the *only* detection method
  (name a stack's tool as an example, not a requirement — see how A11Y-01's
  discovery hints cover Chakra, styled-components, and plain semantic HTML
  side by side). If a change only makes sense for one stack or one project,
  it belongs in that project's own `project-checklist.md`, not here.
- **Read-only by default.** The skill's job is to report gaps, not fix
  them. Any workflow change that would make it edit code, commit, or open
  tickets without explicit user approval first is out of scope.
- **Evidence-first.** `a11y-audit.md`'s Rules section already requires
  re-running a category's detection recipe before reporting a gap as real,
  and requires a manual/live check before a keyboard or screen-reader
  finding counts. New categories should carry the same discipline — a grep
  hit or an automated-scanner flag is a candidate, not a finding.
- **Each category is self-contained.** What it is → the WCAG Success
  Criterion it maps to → why it matters → how to detect it generically →
  discovery hints across a few common stacks → when it's N/A. Keep new
  entries in that shape so the file stays skimmable.
- **Disclose methodology limitations honestly.** This skill does manual,
  source-grounded review plus live DOM checks when a dev server is
  reachable — it does not run an automated scanner (axe-core/Pa11y/
  Lighthouse) by default and it cannot drive a real screen reader. Don't add
  wording anywhere that implies broader coverage than that.

## Reporting a problem with the skill

Open an issue with: which category (e.g. `A11Y-09`), what the skill told you
to check or how it phrased the finding, and what was wrong or unclear about
it. If a detection approach or discovery hint turned out not to generalize
across stacks the way it claims to, that's a good bug report — include which
stack broke it.

## Adding a new category

- Only add a category that's a **universal** WCAG 2.2 AA practice —
  applicable across projects and frameworks, not specific to how one site
  happens to be built.
- Follow the existing six-part structure (What / WCAG SC / Why / Generic
  detection / Discovery hints / N/A when) and give discovery hints for more
  than one stack where practical.
- Pick the next available `A11Y-NN` ID and add it to the categories summary
  in `README.md` as well as `categories.md`.
- If you're not sure whether something is universal enough, open an issue
  describing the practice before writing the full entry — cheaper to align
  on scope early than to rewrite it.

## Adding to the workflow (`a11y-audit.md`)

Changes here should make the audit more accurate or more useful across *any*
project, not encode assumptions from one codebase. If your change assumes a
particular file-tree convention (e.g. where `project-checklist.md` lives, how
`.claude/commands/` is wired), call that out explicitly as a convention
rather than baking it in silently. Never weaken the read-only default or the
"re-verify before reporting a gap" rule to make the audit faster.
