---
name: jj-flow
description: The workflow used in this project for planning and organising work using `jj` VCS
---

This project uses `jj` as its version control system (VCS) instead of git. `jj` allows you to create empty "future" commits which are descendants of the current working copy and we use these to plan out future work.

```sh
jj new --after @ --message 'TODO: future task to work on'
```

- `--after @` add the new change as a child of the current working change (`@`)
- `--message` provides the change description

Within each commit we plan out the work to be implemented by leaving detailed code comments (e.g `// AI: ...task description...`)

When it comes to then implementing those changes, we first switch to the first unimplemented commit (`jj edit <change_id>`), view the list of tasks to be completed in this commit (`jj diff`), and then analyse the related code and implement all of those tasks using test driven development. Once all of the tasks in that commit have been implemented and all of the tests pass we update the commit message (`jj describe -m "New commit message"`) and before moving on to the next unimplemented commit.

## Change description format

For future planned changes include:

- A short and concise one line description of the task/change prefixed with `TODO:`
- A blank line
- The path to the relevant spec file for this change, e.g. `Spec: specs/spec-file.md`
- Any additional context which is helpful to understand why this change is being made

## Example planning workflow

Planning future work:

```sh
~/p/test> jj log
@  o      sgrowe       8 seconds ago 38f2ddc6
│  Current working change
│
◆  z      root() 00000000

~/p/test> jj new --after @ --message 'TODO: future task to work on'
Working copy (@) now at: l      7d04fc34 (empty) TODO: future task to work on
Parent commit (@-):      o      38f2ddc6 Current working change
Added 1 files, modified 0 files, removed 0 files

# Add // AI: comments to relevant files describing the implementation tasks
~/p/test> echo '// AI: implement the future task logic' >> x.txt
~/p/test> jj log
@  l      sgrowe       2 seconds ago 7d04fc34
│  TODO: future task to work on
│
○  o      sgrowe       20 seconds ago 38f2ddc6
│  Current working change
│
◆  z      root() 00000000

~/p/test> jj new --after @ --message 'TODO: a second task to work on after `l`'
Working copy (@) now at: v      09291616 (empty) TODO: a second task to work on after `l`
Parent commit (@-):      l      7d04fc34 TODO: future task to work on
Added 1 files, modified 0 files, removed 0 files

# Add // AI: comments for the second task
~/p/test> echo '// AI: implement the second task' >> x.txt
~/p/test> jj log
@  v      sgrowe       2 seconds ago 09291616
│  TODO: a second task to work on after `l`
│
○  l      sgrowe       32 seconds ago 7d04fc34
│  TODO: future task to work on
│
○  o      sgrowe       50 seconds ago 38f2ddc6
│  Current working change
│
◆  z      root() 00000000

# Return to the original working copy
~/p/test> jj edit o
Working copy (@) now at: o      38f2ddc6 Current working change
Parent commit (@-):      z      00000000 (empty) (no description set)
Added 0 files, modified 0 files, removed 0 files
~/p/test> jj log
○  v      sgrowe       32 seconds ago 09291616
│  TODO: a second task to work on after `l`
│
○  l      sgrowe       1 minute ago 7d04fc34
│  TODO: future task to work on
│
@  o      sgrowe       2 minutes ago 38f2ddc6
│  Current working change
│
◆  z      root() 00000000
```

## Implementing planned changes

To then start working on these planned items you would, one at a time:

- switch to the change we will now be working on (`jj edit <change_id>`)
- view the change description and planned changes in the current commit (`jj show`) along with the linked spec file, and explore all of the related code
- create a task list of all the tasks to be done as part of this commit and then carry them out

## Completing a change

Once a change has been completed, carry out this checklist:

- make sure all of the acceptance criteria have been met (e.g. run the relevant tests and lints and verify they pass)
- double check all `// AI:` comments have been implemented and removed
- update the change description to remove the `TODO:`, and add a clear description of what changes were made and why
- update the relevant spec doc for this change with any insights gained, and make sure it is still accurate and up-to-date

Once you have completed all of the above steps then continue with implementing the next `TODO:` change (repeating the steps above)

## `jj` CLI

```sh
# See all available `jj` commands
jj help

# Help with a specific command
jj log --help
jj describe --help

# Help with jj terminology
jj help -k glossary

# Help with the revsets syntax
jj help -k revsets
```
