relative_load('../utils/actions_factory.lua')
relative_load('../utils/utils.lua')
create_default_actions("luadotheworld")


function PushBlind.actions.build_deps()
    local repo = get_prop("luadotheworld_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo dotheworld <luadotheworld_repo>' first")
    end

    build_deps({
        project = "luadotheworld",
        dep = "luacembed",
        actions = {"build_deps"},
        sources = {
            { target = "release/LuaCEmbedOne.c", dest = "dependencies/LuaCEmbedOne.c" },
        }
    })

    build_deps({
        project = "luadotheworld",
        dep = "doTheWorld",
        actions = {"build_deps"},
        sources = {
            { target = "release/doTheWorldOne.c", dest = "dependencies/doTheWorldOne.c" },
        }
    })
end

function PushBlind.actions.build()
    local repo = get_prop("luadotheworld_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo dotheworld <luadotheworld_repo>' first")
    end

    
    PushBlind.run_action("luadotheworld", "build_deps")
    os.execute("cd "..repo.." && darwin run_blueprint build/ --mode folder build_release")
end

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