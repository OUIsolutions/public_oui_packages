
relative_load('../utils/actions_factory.lua')
create_default_actions("c-react", "OUIsolutions/C-React")


function PushBlind.actions.publish()
    local repo = get_prop("c-react_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo c-react <c-react_repo>' first")
    end
    os.execute("cd "..repo.." && vibescript shipyard  release.json")
    print("Published to repo "..repo)

end 

-- Project is single file, no build_deps needed