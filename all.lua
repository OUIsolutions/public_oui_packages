

function PushBlind.actions.update()
    print("runned")
    PushBlind.add_package({
        package_name = "OUIsolutions/public_oui_packages",
        filename = "vibescript.lua",
        name = "vibescript",
        force=false
    })
    return true
end
