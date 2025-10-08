

relative_load('../utils/actions_factory.lua')
create_default_actions("clpr")


function PushBlind.actions.publish()
    local repo = get_prop("clpr")
    if not repo then
        error("You need to run: 'pushblind set_repo clpr <clpr_repo>' first")
    end
    os.execute("cd "..repo.." && darwin run_blueprint --target all")
    os.execute("cd "..repo.." && vibescript shipyard  release.json")
    print("Published to repo "..repo)

end 


