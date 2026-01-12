relative_load('../utils/actions_factory.lua')
create_default_actions("doTheWorld")


function PushBlind.actions.build()
    local repo = get_prop("doTheWorld_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo doTheWorld <doTheWorld_repo>' first")
    end

    os.execute("cd " .. repo .. " && darwin install darwindeps.json --soft")
    os.execute("cd " .. repo .. " && darwin run_blueprint --target all")
end
