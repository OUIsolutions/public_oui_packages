relative_load('../utils/utils.lua')
relative_load('../utils/actions_factory.lua')
create_default_actions("cwebstudio")


function PushBlind.actions.scratch_install()
    local repo = get_prop("cwebstudio_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo cwebstudio <cwebstudio_repo>' first")
    end

    build_deps({
        project = "cwebstudio",
        dep = "cJSON",
        actions = {},
        sources = {
            { target = "cJSON.c", dest = "dependencies/cJSON.c" },
            { target = "cJSON.h", dest = "dependencies/cJSON.h" }
        }
    })

    build_deps({
        project = "cwebstudio",
        dep = "universalsocket",
        actions = {"build"},
        sources = {
            { target = "UniversalSocket.c", dest = "dependencies/UniversalSocket.c" },
            { target = "UniversalSocket.h", dest = "dependencies/UniversalSocket.h" }
        }
    })

    build_deps({
        project = "cwebstudio",
        dep = "universalGarbageCollector",
        actions = {"build"},
        sources = {
            { target = "release/UniversalGarbage.c", dest = "dependencies/UniversalGarbage.c" },
            { target = "release/UniversalGarbage.h", dest = "dependencies/UniversalGarbage.h" }
        }
    })

    build_deps({
        project = "cwebstudio",
        dep = "ctextengine",
        actions = {"build"},
        sources = {
            { target = "release/CTextEngine.c", dest = "dependencies/CTextEngine.c" },
            { target = "release/CTextEngine.h", dest = "dependencies/CTextEngine.h" }
        }
    })
    

    os.execute("cd " .. repo .. " && darwin run_blueprint --target all")
end

function PushBlind.actions.publish()
   local repo = get_prop("cwebstudio_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo cwebstudio <cwebstudio_repo>' first")
    end

    dtw.remove_any(repo.."/dependencies")
    dtw.remove_any(repo.."/release")

    os.execute("cd "..repo.." && darwin install darwindeps.json ")
    os.execute("cd "..repo.." && darwin run_blueprint --target all")
    os.execute("cd "..repo.." && vibescript shipyard  release.json")
    print("Published to repo "..repo)

end