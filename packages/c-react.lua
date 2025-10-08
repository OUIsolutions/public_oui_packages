
relative_load('../utils/actions_factory.lua')
create_default_actions("c-react")


function PushBlind.actions.publish()
    local repo = get_prop("c-react")
    if not repo then
        error("You need to run: 'pushblind set_repo c-react <c-react_repo>' first")
    end
    os.execute("cd "..repo.." && vibescript shipyard  release.json")
    print("Published to repo "..repo)

end 
