relative_load('../utils/actions_factory.lua')
relative_load('../utils/utils.lua')

create_default_actions("BearHttpsClient")

function PushBlind.actions.build_deps()
    local bear_repo = get_prop("BearHttpsClient_repo")
    if not bear_repo then
        error("You need to run: 'pushblind set_repo BearHttpsClient <BearHttpsClient_repo>' first")
    end
    os.execute("cd " .. bear_repo .. " && darwin install darwindeps.json --soft")


    PushBlind.run_action("c2wasm","build")
    move_dep("c2wasm", "c2wasm.c", "BearHttpsClient", "dependencies/c2wasm.c")

end

function PushBlind.actions.build()
    local repo = get_prop("BearHttpsClient_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo BearHttpsClient <BearHttpsClient_repo>' first")
    end
    os.execute("cd " .. repo .. " && darwin run_blueprint --target all")
end
