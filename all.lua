

function PushBlind.actions.update()
    PushBlind.add_package({
        repo = PushBlind.same,
        filename = "vibescript.lua",
        name = "vibescript",
        force=false
    })
    return true
end
