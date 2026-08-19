# a11y-audit — a Claude Code skill for WCAG 2.2 AA completeness audits

A portable [Claude Code](https://claude.com/claude-code) skill that
performs a **repo-wide, read-only sweep for missing or incomplete WCAG 2.2
AA accessibility practices** — not a linter, not a single bug fix, but a
completeness check against a fixed 30-category checklist covering
semantic structure, labeled controls, keyboard operability, focus
management, color contrast, captions, motion, target size, and more (see
[`skills/a11y-audit/categories.md`](skills/a11y-audit/categories.md) for
the full list).

It's framework-agnostic — the category definitions have no hardcoded
paths, and the skill's own discovery workflow figures out where things
live in *your* codebase on first run.

## Quick install (one line)

From your project's repo root:

```bash
curl -sL https://raw.githubusercontent.com/tushar33/a11y-audit-skill/main/install.sh | bash
```

This copies `skills/a11y-audit/{a11y-audit.md,categories.md,README.md}`
and an empty `project-checklist.md` stub into your project, and symlinks
the skill into `.claude/commands/a11y-audit.md` so Claude Code picks it
up as `/a11y-audit`.

## Manual install

```bash
git clone https://github.com/tushar33/a11y-audit-skill.git /tmp/a11y-audit-skill
mkdir -p skills .claude/commands
cp -r /tmp/a11y-audit-skill/skills/a11y-audit skills/
ln -s ../../skills/a11y-audit/a11y-audit.md .claude/commands/a11y-audit.md
```

## Use it

In Claude Code, from your project:

```
/a11y-audit                     # audit every category
/a11y-audit A11Y-09              # audit one category only
/a11y-audit add: <describe a new universal WCAG practice to track>
```

On a fresh install, `skills/a11y-audit/project-checklist.md` starts
empty — the first run discovers your codebase's structure and populates
it. Every later run re-verifies each entry's last-known state instead of
starting over, and the file accumulates as a fast, project-specific audit
trail (never delete history, only cross‑verified updates).

Findings never trigger an automatic fix — the skill is read-only by
design. Fixing is a separate, explicit step.

## What this skill is (and isn't)

- **Is:** a structured, source-grounded manual review, with live
  browser/DOM verification when a dev server or staging URL is reachable
  (via Playwright, if available in your project).
- **Isn't:** a substitute for an automated scanner (axe-core, Pa11y,
  Lighthouse) or for real assistive-technology testing (NVDA, JAWS,
  VoiceOver, TalkBack). The skill discloses both limitations in every
  report rather than implying broader coverage than it actually has — see
  `categories.md`'s `A11Y-30` entry and `a11y-audit.md`'s "Methodology
  limitations" section.

## Repo layout

```
skills/a11y-audit/
├── a11y-audit.md          # the skill definition itself (generic, portable)
├── categories.md          # the 30 WCAG 2.2 AA categories (generic, portable)
├── README.md              # skill-level documentation
└── project-checklist.md   # empty stub — becomes your project's audit state
.claude/commands/
└── a11y-audit.md          # symlink → skills/a11y-audit/a11y-audit.md
install.sh                 # one-line installer
```

## Contributing

Found a WCAG practice this checklist misses, or discovery hints that are
wrong/incomplete for a common stack? PRs to `categories.md` welcome — keep
it free of any hardcoded, project-specific paths so it stays portable.

See [CONTRIBUTING.md](CONTRIBUTING.md) for ground rules before opening a PR.

## License

MIT — see [`LICENSE`](LICENSE).
