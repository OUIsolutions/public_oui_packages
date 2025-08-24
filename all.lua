

function PushBlind.actions.update()
    PushBlind.add_package({
        repo = PushBlind.same,
        filename = "vibescript.lua",
        name = "vibescript",
        force=false
    })

        PushBlind.add_package({
        repo = PushBlind.same,
        filename = "darwin.lua",
        name = "darwin",
        force=false
    })
    return true
end
