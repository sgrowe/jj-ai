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
5. For each planned change, create a new commit and add `// AI:` comments:

```sh
jj new --after <parent> --message '<change description>'
```

Where `<parent>` is `@` for the first change and the change ID of the previous planned change for subsequent ones. This moves the working copy to the new commit so you can edit files in it.

6. Format each change description following the jj-flow convention:
   - First line: `TODO: <short description>`
   - Blank line
   - `Spec: <path to relevant spec file>` (if one exists)
   - Any additional context helpful to understand why this change is being made

7. Add detailed `// AI:` comments to the relevant source files within the new commit. These comments describe the specific implementation tasks to be carried out. Place them near the code that needs to change. For example:
   - `// AI: add validation for the email field here`
   - `// AI: refactor this function to accept an options object`

8. After creating all planned commits, return to the original working copy:

```sh
jj edit <original_change_id>
```

9. Run `jj log` to check and review the finished plan

## Important

- Keep each planned change small and focused — one logical unit of work
- Order changes so earlier ones don't depend on later ones
- We will follow test driven development for every change, so include `// AI:` comments in the related test files (for new tests) and any existing tests which may need updating
- Implementation details go in `// AI:` code comments within the commit's files, not in commit descriptions
- Commit descriptions should be concise — just the `TODO:` summary, spec path, and context
