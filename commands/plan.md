---
description: Plan future work by creating jj TODO commits
allowed-tools: Bash, Read, Glob, Grep, Task
argument-hint: <description of work to plan>
---

You are starting a planning session using the jj-flow workflow. Load the jj-flow skill from this plugin for full context on the workflow.

Your goal is to help the user plan out future work as a sequence of empty jj commits descending from the current working copy.

## Steps

1. Run `jj log --limit 20` to understand the current state of the repo
2. If `$ARGUMENTS` is provided, use it as the description of the work to plan. Otherwise, ask the user what they want to plan.
3. Explore the codebase to understand the relevant code and architecture for the planned work
4. Break the work down into a sequence of small, focused changes. Each change should be independently completable and testable.
5. For each planned change, create a new empty commit using the jj-flow convention:

```sh
jj new --no-edit --after <parent> --message '<change description>'
```

Where `<parent>` is `@` for the first change and the change ID of the previous planned change for subsequent ones.

6. Format each change description following the jj-flow convention:
   - First line: `TODO: <short description>`
   - Blank line
   - `Spec: <path to relevant spec file>` (if one exists)
   - Detailed implementation plan
   - Acceptance criteria

7. After creating all planned commits, run `jj log` to show the user the resulting plan

## Important

- Keep each planned change small and focused — one logical unit of work
- Order changes so earlier ones don't depend on later ones
- Include concrete acceptance criteria (e.g. specific tests to pass)
- Use `jj new --no-edit --after <change_id>` to chain changes sequentially
