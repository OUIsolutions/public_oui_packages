relative_load('../utils/actions_factory.lua')
create_default_actions("BearHttpsClient")


function PushBlind.actions.build()
    local repo = get_prop("BearHttpsClient_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo BearHttpsClient <BearHttpsClient_repo>' first")
    end
    os.execute("cd " .. repo .. " && darwin run_blueprint --target all")
end
