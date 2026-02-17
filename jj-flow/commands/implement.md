---
description: Implement planned jj TODO commits
argument-hint: "[revset or jj log command] (optional)"
---

You are implementing planned TODO changes using the jj-flow workflow. Load the jj-flow skill from this plugin for full context on the workflow.

## Determine which changes to implement

If `$ARGUMENTS` is provided it is either:

- A **jj revset** expression (e.g. `@+`, `mq`, `mq::vn`) — run `jj log -r '$ARGUMENTS'` to find the changes
- A **full jj log command** (e.g. `jj log -r 'descendants(@) & description("TODO:*")'`) — run it directly

If no arguments are provided, find all TODO changes that are descendants of the current working copy:

```sh
jj log -r 'descendants(@) & description("TODO:*")'
```

## Implement each change

For each TODO change, in order from nearest to furthest descendant:

1. **Switch to the change**: `jj edit <change_id>`
2. **Review the plan**: Run `jj show` to read the change description and the `// AI:` comments in the diff
3. **Explore the code**: Read all relevant files referenced in the spec and the `// AI:` comments
4. **Create a task list** from the `// AI:` comments in the code
5. **Carry out the plan**: Implement each `// AI:` task, writing code, tests, etc. Remove each `// AI:` comment once its task is done.
6. **Verify**: Run the relevant tests and checks. If they don't pass, stop and ask the user for help.
7. **Complete the change** following the jj-flow checklist:
   - Run relevant tests and lints and verify they pass
   - Double check all `// AI:` comments have been implemented and removed
   - Remove the `TODO:` prefix: `bash ${CLAUDE_PLUGIN_ROOT}/scripts/remove_todo.sh`
   - Update the change description with a clear description of what was done and why
   - Update any relevant spec docs with insights gained

8. **Continue** to the next TODO change

## Important

- Implement changes in order — earlier changes may be prerequisites for later ones
- If a change's implementation plan is unclear or insufficient, stop and ask the user
- Do not skip any acceptance criteria checks
- After completing all changes, run `jj log` to show the final state
