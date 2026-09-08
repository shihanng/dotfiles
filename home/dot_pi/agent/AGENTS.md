# Global Pi Instructions

## Exploration delegation

Before using `read`, `ffgrep`, `fffind`, `bash`, `web_search`, `fetch_content`,
`source_check`, or MCP discovery, decide whether the request requires
*discovery*—locating information that is not already in context.

- For any non-trivial discovery across the codebase, documentation, tickets,
  wikis, services, or the web, automatically launch the `explore-v2`
  subagent with `Agent(subagent_type: "explore-v2", ...)`.
- Treat `explore-v2` as the default research and reconnaissance agent. Launch
  it proactively; do not wait for the user to request a subagent.
- Launch it in the background and continue only with independent work. Once it
  completes, use its findings rather than repeating its searches inline.
- Do **not** use a multi-agent workflow merely to perform one exploration
  task. Use a workflow only when the user explicitly requests orchestration or
  the work genuinely needs coordinated multi-agent stages.
- The only inline exception is a trivial, bounded lookup: the exact file or
  URL is already known, and one small `read` or fetch will answer the question.
  If more searching, cross-referencing, or source selection is needed, delegate
  to `explore-v2`.
- Prefer the built-in `Explore` agent only for a fast, codebase-only location
  lookup that has no need for web, documentation, ticket, wiki, or MCP access.
  Otherwise use `explore-v2`.
- Give the subagent a clear question, relevant known context, and whether the
  result must include paths, line numbers, URLs, source passages, or API
  details. Ask it to remain read-only unless the user expressly requests
  changes.

## Open-source documentation lookups

When `explore-v2` investigates documentation for an open-source project,
library, package, or tool:

- Identify the upstream repository and query DeepWiki first for the specific
  behavior or API in question.
- If DeepWiki is unavailable, the repository is not indexed, or its answer is
  insufficient, fall back to versioned official documentation, Context7, or
  upstream source code. State the fallback reason briefly.
- For version-sensitive APIs, verify that the evidence applies to the version
  in use.
