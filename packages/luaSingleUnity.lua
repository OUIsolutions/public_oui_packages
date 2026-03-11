relative_load('../utils/actions_factory.lua')
create_default_actions("luaSingleUnity")

function PushBlind.actions.build()
    local repo = get_prop("luaSingleUnity_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo luaSingleUnity <luaSingleUnity_repo>' first")
    end

    os.execute("cd "..repo.." && darwin run_blueprint darwinconf.lua --version 5.4.7")
end