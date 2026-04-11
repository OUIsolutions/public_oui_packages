
relative_load('../utils/actions_factory.lua')
relative_load('../utils/utils.lua')

create_default_actions("lplot", "OUIsolutions/lplot")

function PushBlind.actions.build()
    local repo = get_prop("lplot_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo lplot <lplot_repo>' first")
    end
    os.execute("cd " .. repo .. " && darwin run_blueprint --target all")
end

function PushBlind.actions.publish()
    local repo = get_prop("lplot_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo lplot <lplot_repo>' first")
    end

    dtw.remove_any(repo.."/dependencies")
    dtw.remove_any(repo.."/release")

    os.execute("cd "..repo.." && darwin install darwindeps.json ")
    os.execute("cd "..repo.." && darwin run_blueprint --target all")
    os.execute("cd "..repo.." && vibescript shipyard  release.json")
    print("Published to repo "..repo)

end
