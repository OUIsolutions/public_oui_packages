
relative_load('../utils/actions_factory.lua')
create_default_actions("luadotheworld")

function PushBlind.actions.publish()
   local repo = get_prop("luadotheworld_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo dotheworld <luadotheworld_repo>' first")
    end

    dtw.remove_any(repo.."/dependencies")
    dtw.remove_any(repo.."/release")

    os.execute("cd "..repo.." && darwin install darwindeps.json ")
    os.execute("cd "..repo.." && darwin run_blueprint build/ --mode folder build_release")
    dtw.remove_any(repo.."/release/luaDoTheWorld.zip")
    os.execute("cd "..repo.."/release && zip -r luaDoTheWorld.zip luaDoTheWorld")

    os.execute("cd "..repo.." && vibescript shipyard  release.json")
    print("Published to repo "..repo)

end