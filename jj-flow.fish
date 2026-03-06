
set -l change_ids (jj log -r 'all()' --limit 10 -T 'change_id ++ "\n"' --no-graph)

echo "Op log position before starting:"
jj op log --limit 1

for change in change_ids
    echo "Implementing $change"
    jj edit $change
    jj status
    claude -p "/ralph-loop:ralph-loop 'Implement these changes using test-driven development: $(jj show $change --git)' --completion-promise \"DONE\""
    jj status
end
