---
name: write-pr-description
description: Write desctiption for a pull request
---

## What I do

- Confirm whether the project uses JJ or Git.
- Based on the version control system in use, find the diff between the current branch and the target branch for the merge. Ask if you're unsure.
  - For Git projects, use `git log <target_branch>..<current_branch>` to list all relevant commits.
  - For JJ projects, use `jj log -r '<target_branch>..<current_branch>'` to list all relevant commits.
- Summarize the changes in the diff and write a pull request description. Reference the commit descriptions from each commit. Include what changed, why it changed, and any relevant context to help reviewers understand the changes. DO NOT write about the HOW.

## When to use me

Use this when you need to write a description for a pull request.
