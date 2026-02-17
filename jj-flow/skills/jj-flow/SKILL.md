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

This project follows strict test-driven development (TDD). During **planning**, each commit is seeded with **failing tests** that define the expected behaviour for that commit. `// AI:` comments are added alongside the tests as hints to guide and speed up the implementation. The tests are the specification — they define what "done" looks like.

During **implementation**, we switch to a planned commit, read its failing tests and `// AI:` hints, then write the production code to make all the tests pass. Once every test passes and all `// AI:` comments have been addressed and removed, the commit is complete.

## Planning a commit

Each planned commit must contain:

1. **Failing tests** — Write test cases that describe the expected behaviour for this commit. The tests must fail (red) because the production code doesn't exist yet. Tests should be thorough enough to fully specify the commit's scope.
2. **`// AI:` hint comments** — Add concise comments in the relevant source files (not the test files) to guide the implementor. These are hints, not the specification — the tests are the specification.

The tests and hints together should make it possible for someone (or an AI) to implement the commit without needing any other context beyond the linked spec file.

## Change description format

For future planned changes include:

- A short and concise one line description of the task/change prefixed with `TODO:`
- A blank line
- The path to the relevant spec file for this change, e.g. `Spec: specs/spec-file.md`
- Any additional context which is helpful to understand why this change is being made

## Example planning workflow

Planning future work. For each planned commit: create the commit, add failing tests, and add `// AI:` hints in the source files.

```sh
~/p/test> jj log
@  o      sgrowe       8 seconds ago 38f2ddc6
│  Current working change
│
◆  z      root() 00000000

~/p/test> jj new --after @ --message 'TODO: add user validation'
Working copy (@) now at: l      7d04fc34 (empty) TODO: add user validation
Parent commit (@-):      o      38f2ddc6 Current working change

# Seed the commit with failing tests that specify the expected behaviour
~/p/test> cat >> tests/user_test.rs << 'EOF'
#[cfg(test)]
mod validate_user_tests {
    use super::*;

    #[test]
    fn rejects_empty_username() {
        let result = validate_user("");
        assert!(!result.is_valid);
        assert_eq!(result.errors, vec!["Username is required"]);
    }

    #[test]
    fn accepts_valid_username() {
        let result = validate_user("alice");
        assert!(result.is_valid);
        assert!(result.errors.is_empty());
    }
}
EOF

# Add // AI: hints in the source files to guide the implementation
~/p/test> cat >> src/user.rs << 'EOF'
// AI: implement validate_user — see tests/user_test.rs for the full spec
// AI: username must be non-empty, return ValidationResult { is_valid, errors }
EOF

~/p/test> jj log
@  l      sgrowe       2 seconds ago 7d04fc34
│  TODO: add user validation
│
○  o      sgrowe       20 seconds ago 38f2ddc6
│  Current working change
│
◆  z      root() 00000000

~/p/test> jj new --after @ --message 'TODO: add email validation'
Working copy (@) now at: v      09291616 (empty) TODO: add email validation
Parent commit (@-):      l      7d04fc34 TODO: add user validation

# Seed with failing tests
~/p/test> cat >> tests/user_test.rs << 'EOF'
#[cfg(test)]
mod validate_email_tests {
    use super::*;

    #[test]
    fn rejects_invalid_email() {
        assert!(!validate_email("not-an-email"));
    }

    #[test]
    fn accepts_valid_email() {
        assert!(validate_email("alice@example.com"));
    }
}
EOF

# Add // AI: hints
~/p/test> cat >> src/user.rs << 'EOF'
// AI: implement validate_email — basic format check, see tests
EOF

# Return to the original working copy
~/p/test> jj edit o
~/p/test> jj log
○  v      sgrowe       32 seconds ago 09291616
│  TODO: add email validation
│
○  l      sgrowe       1 minute ago 7d04fc34
│  TODO: add user validation
│
@  o      sgrowe       2 minutes ago 38f2ddc6
│  Current working change
│
◆  z      root() 00000000
```

## Implementing planned changes

To start working on planned items, one commit at a time:

1. Switch to the commit: `jj edit <change_id>`
2. Read the change description (`jj show`) and the linked spec file
3. **Run the tests** — they should fail (red). This confirms the tests are correctly seeded and the work hasn't already been done
4. Read the failing tests to understand the expected behaviour, and read the `// AI:` hints in the source files
5. Write the production code to make all the failing tests pass
6. Remove all `// AI:` comments once implemented
7. Run the full test suite and lints to verify everything passes (green)

## Completing a change

Once a change has been completed, carry out this checklist:

- **All tests pass** — run all tests related to the area we're working on to check for regressions
- **All `// AI:` comments removed** — double check none remain in the diff
- **Lints and typechecks pass** — run the linter and typechecker
- Update the change description to remove the `TODO:` prefix using `jj describe -m "New commit message"`. Add a clear description of what changes were made and why
- Update the relevant spec doc for this change with any insights gained, and make sure it is still accurate and up-to-date

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
