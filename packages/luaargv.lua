relative_load('../utils/actions_factory.lua')
relative_load('../utils/utils.lua')

create_default_actions("luaargv")

function PushBlind.actions.build()
    local repo = get_prop("luaargv_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo BearHttpsClient <BearHttpsClient_repo>' first")
    end
    
    os.execute("cd " .. repo .. " && darwin run_blueprint darwinconf.lua ")
end
