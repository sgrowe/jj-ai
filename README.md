# Claude plugin for jj VCS

A Claude Code plugin for planning and organising work using [jj](https://github.com/jj-vcs/jj) VCS.

Uses empty "future" commits to plan out work as a chain of TODO changes descending from the current working copy, then implements them one at a time.

## Installation

```sh
claude plugin add https://github.com/sgrowe/jj-ai
```

## Commands

### `/jj-vcs:plan`

Start a planning session. Explores the codebase and creates a chain of TODO commits for the work described.

```
/jj-vcs:plan add input validation to the API endpoints
```

### `/jj-vcs:implement`

Implement planned TODO commits. Works through each change in order — reading the plan, implementing it, verifying acceptance criteria, and updating the description.

```
# Implement all TODO descendants of the current change
/jj-vcs:implement

# Implement a specific change by revset
/jj-vcs:implement mq

# Implement a range of changes
/jj-vcs:implement mq::vn

# Use a custom jj log command to select changes
/jj-vcs:implement jj log -r 'descendants(@) & description("TODO:")'
```

## Skill

The plugin includes the `jj-flow` skill which documents the full workflow convention — change description format, planning workflow, implementation steps, and completion checklist. The commands load this skill automatically.
