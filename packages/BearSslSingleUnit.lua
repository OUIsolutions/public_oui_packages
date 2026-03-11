relative_load('../utils/actions_factory.lua')
create_default_actions("BearSslSingleUnit")
  

function PushBlind.actions.build()
    local repo = get_prop("BearSslSingleUnit_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo BearSslSingleUnit <BearSslSingleUnit_repo>' first")
    end
    
    os.execute("cd "..repo.." &&  darwin run_blueprint --mode folder build/ update_bear create_patch build generate_release")
end

function PushBlind.actions.build_deps()
    -- build_deps action is needed for the recursive build process of dependants to work,
    -- but since there are no dependencies, just call the build action directly
    PushBlind.actions.build()
end