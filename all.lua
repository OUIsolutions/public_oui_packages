

function PushBlind.actions.update()
        PushBlind.add_package({
            repo = PushBlind.same,
            filename = "vibescript.lua",
            name = "vibescript",
            force=false
        })

        PushBlind.add_package({
            repo = PushBlind.same,
            filename = "cwebstudio_firmware.lua",
            name = "cwebstudio_firmware",
            force=false
        })


        PushBlind.add_package({
        repo = PushBlind.same,
        filename = "darwin.lua",
        name = "darwin",
        force=false
    })

        PushBlind.add_package({
        repo = PushBlind.same,
        filename = "cachify.lua",
        name = "cachify",
        force=false
    })

        PushBlind.add_package({
        repo = PushBlind.same,
        filename = "shipyard.lua",
        name = "shipyard",
        force=false
    })
    
    return true
end
