

relative_load('../utils/actions_factory.lua')
create_default_actions("luacembed")

function PushBlind.actions.build_deps()
    build_deps({
        project = "luacembed",
        dep = "UniversalGarbageCollector",
        actions = {"build"},
        sources = {
            { target = "release/UniversalGarbage.h", dest = "dependencies/UniversalGarbage.h" },
            { target = "release/UniversalGarbage.c", dest = "dependencies/UniversalGarbage.c" },
        }
    })

    build_deps({
        project = "luacembed",
        dep = "luaSingleUnity",
        actions = {"build"},
        sources = {
            { target = "release/lua_single_unity_classic_onelua.c", dest = "dependencies/lua_single_unity_classic_onelua.c" },
            { target = "release/lua_single_unity.h", dest = "dependencies/lua_single_unity.h" },
        }
    })
end

function PushBlind.actions.publish()
   local repo = get_prop("luacembed_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo luacembed <luacembed_repo>' first")
    end

    dtw.remove_any(repo.."/dependencies")
    dtw.remove_any(repo.."/release")

    os.execute("cd "..repo.." && darwin install darwindeps.json ")
    os.execute("cd "..repo.." && darwin run_blueprint --target all")
    os.execute("cd "..repo.." && vibescript shipyard  release.json")
    print("Published to repo "..repo)

end


