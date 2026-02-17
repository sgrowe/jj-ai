# Claude plugins for jj VCS

A Claude Code plugin marketplace for [jj](https://github.com/jj-vcs/jj) VCS.

## jj-flow

Plans and organises work using empty "future" commits as a chain of TODO changes descending from the current working copy, then implements them one at a time.

## Installation

Add the following to `.claude/settings.json`:

```json
{
  // .claude/settings.json
  "extraKnownMarketplaces": {
    "company-tools": {
      "source": {
        "source": "github",
        "repo": "sgrowe/jj-ai"
      }
    }
  },
  "enabledPlugins": {
    "jj-flow@jj-ai": true
  }
}
```

or interactively:

```sh
claude plugin add https://github.com/sgrowe/jj-ai
```

## Commands

### `/jj-flow:plan`

Start a planning session. Explores the codebase and creates a chain of TODO commits for the work described.

```
/jj-flow:plan add input validation to the API endpoints
```

### `/jj-flow:implement`

Implement planned TODO commits. Works through each change in order — reading the plan, implementing it, verifying acceptance criteria, and updating the description.

```
# Implement all TODO descendants of the current change
/jj-flow:implement

# Implement a specific change by revset
/jj-flow:implement mq

# Implement a range of changes
/jj-flow:implement mq::vn

# Use a custom jj log command to select changes
/jj-flow:implement jj log -r 'descendants(@) & description("TODO:")'
```

## Skill

The plugin includes the `jj-flow` skill which documents the full workflow convention — change description format, planning workflow, implementation steps, and completion checklist. The commands load this skill automatically.
