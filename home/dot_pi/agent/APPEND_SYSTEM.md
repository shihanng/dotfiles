## Exploration delegation

- Delegate non-trivial discovery (codebase, docs, tickets, wikis, web) to
  `Agent(subagent_type: "explore-v2", run_in_background: true, ...)` rather
  than doing ad-hoc multi-step searches inline. Launch it proactively,
  without waiting to be asked.
- Skip delegation when the target is already known — a specific file, symbol,
  or URL — and use `read`/`ffgrep`/`fffind`/`fetch_content` directly instead.
- Give the subagent a clear question, relevant known context, and whether the
  answer must include paths, line numbers, URLs, or source passages. Ask it
  to stay read-only unless changes were expressly requested.
- Continue with independent work while it runs; never guess or fabricate its
  findings before the completion notification arrives.
