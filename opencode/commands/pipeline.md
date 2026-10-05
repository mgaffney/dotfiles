---
description: The multi-agent pipeline — invocation guide. Re-read on demand.
---

# The Multi-Agent Pipeline

Match the ceremony to the risk. Most work uses the Lite tier.

## Choose the tier by novelty of threat surface (not file count)

**Lite tier** (default for most multi-file work):

```
Pre-grep the tree → @architect (plan + "Conditions for Builder")
  → @builder (code + inline tests) → @security (code review)
  → run tests → one install → commit
```

**Full tier** (only for genuinely novel risk — auth/credentials, network egress,
file I/O on untrusted input, dynamic code execution, sandboxing, cryptography, or
any capability with NO analog already shipped in the codebase):

```
@architect → @security (plan) → @builder → @security (code) → @tester
  → one install → commit
```

The difference: a plan-stage security pass and a dedicated tester pass. Lite folds
plan-stage security into the architect's "Conditions for Builder" and lets the
builder write tests inline.

## Skip the pipeline entirely for

Single-line fixes, typos, comment/config changes, and additions that mirror an
existing pattern verbatim — just edit directly.

## Model assignments

Set explicitly per agent in `~/.config/opencode/agents/*.md` (architect → a more
capable model; security, builder, tester → a cheaper/faster model). Don't trust
implicit defaults; state the tier on every invocation.

## Gates between phases

- After the architect: present the plan summary to the human; proceed only when the
  design is agreed. In full tier, security must PASS / CONDITIONAL PASS the plan.
- After the builder: security reviews the actual code on disk. 1–3 small findings →
  fix inline. More, or anything critical/high → send it back.
- Before commit: full suite green, specific files staged, message written.

## Keep the human in the loop at decision points

When a genuine trade-off exceeds a pre-agreed threshold, stop and ask with numbers
and a recommendation — don’t rationalize past it. (And don’t ask about choices with
an obvious default — pick it, state it, move on.)
