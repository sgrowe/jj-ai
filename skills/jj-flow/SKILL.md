---
name: jj-flow
description: The workflow used in this project for planning and organising work using `jj` VCS
---

This project uses `jj` as its version control system (VCS) instead of git. `jj` allows you to create empty "future" commits which are descendants of the current working copy and we use these to plan out future work.

```sh
jj new --no-edit --after @ --message 'TODO: future task to work on'
```

- `--after @` add the new change as a child of the current working change (`@`)
- `--no-edit` means do not make the newly created change the new working change
- `--message` provides the change description

## Change description format

For future planned changes include:

- A short and concise one line description of the task/change prefixed with `TODO:`, followed by a blank line
- The path to the relevant spec file for this change, e.g. `Spec: specs/spec-file.md`
- A detailed and thorough implementation plan
- Acceptance criteria for completion (e.g. specific unit test cases)

## Example planning workflow

Planning future work:

```sh
~/p/test> jj log
@  o      sgrowe       8 seconds ago 38f2ddc6
│  Current working change
│
◆  z      root() 00000000

~/p/test> jj new --no-edit --after @ --message 'TODO: future task to work on'
Created new commit l      7d04fc34 (empty) TODO: future task to work on
~/p/test> jj log
○  l      sgrowe       2 seconds ago 7d04fc34
│  (empty) TODO: future task to work on
│
@  o      sgrowe       20 seconds ago 38f2ddc6
│  Current working change
│
◆  z      root() 00000000

~/p/test> jj status
Working copy changes:
A x.txt
Working copy  (@) : o      38f2ddc6 Current working change
Parent commit (@-): z      00000000 (empty) (no description set)
~/p/test> jj new --no-edit --after l --message 'TODO: a second task to work on after `l`'
Created new commit v      09291616 (empty) TODO: a second task to work on after `l`
~/p/test> jj log
○  v      sgrowe       2 seconds ago 09291616
│  (empty) TODO: a second task to work on after `l`
│
○  l      sgrowe       32 seconds ago 7d04fc34
│  (empty) TODO: future task to work on
│
@  o      sgrowe       50 seconds ago 38f2ddc6
│  Current working change
│
◆  z      root() 00000000

~/p/test> jj status
Working copy changes:
A x.txt
Working copy  (@) : o      38f2ddc6 Current working change
Parent commit (@-): z      00000000 (empty) (no description set)
```

## Implementing planned changes

To then start working on these planned items you would, one at a time:

- switch to the change we will now be working on (`jj edit <change_id>`)
- review the implementation plan in the change description (`jj show`) and explore all of the related code
- create TODO items for each step and then carry out that plan
- test and verify you have met all of the acceptance criteria (if you cannot, stop and ask for assistance from the user)

## Completing a change

Once a change has been completed, carry out this checklist:

- run the relevant tests and lints and verify they pass
- update the relevant spec doc for this change with any insights gained. Also make sure it is still accurate and up-to-date
- update the change description to remove the `TODO:`, and add a clear description of what changes were made and why (remove the implementation plan from the description, it's no longer needed)

Once you have completed all of the above steps then continue with implementing the next `TODO:` change (repeating the steps above)

## `jj` CLI

```sh
# See all available `jj` commands
jj help

# Help with a specific command
jj log --help
jj describe --help
```
