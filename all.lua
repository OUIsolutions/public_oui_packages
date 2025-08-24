

function PushBlind.actions.update()
    PushBlind.add_same_repo_package({
        filename = "vibescript.lua",
        name = "vibescript",
        force=false
    })
    return true
end
