relative_load('../utils/actions_factory.lua')
relative_load('../utils/utils.lua')
create_default_actions("pushblind", "OUIsolutions/PushBlind")
function PushBlind.actions.build_deps()
    local repo = get_prop("pushblind_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo pushblind <pushblind_repo>' first")
    end

    os.execute("cd " .. repo .. " && darwin install darwindeps.json --soft")

    print("Building deps vibescript")
    build_deps({
        project = "pushblind",
        dep = "vibescript",
        actions = {"build_deps", "amalgamate"},
        sources = {
            { target = "release/amalgamation.c", dest = "dependencies/vibescript.c" }
        }
    })
end

function PushBlind.actions.scratch_install()
    PushBlind.run_action("pushblind", "build_deps")

    PushBlind.run_action("pushblind", "repo_install")
end
function PushBlind.actions.repo_install()
    local repo = get_prop("pushblind_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo pushblind <pushblind_repo>' first")
    end

    os.execute("cd " .. repo .. " && darwin install --soft")
    os.execute("cd " .. repo .. " && darwin run_blueprint --target local_unix_bin")
    
    
end
function PushBlind.actions.publish()
    local repo = get_prop("pushblind_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo pushblind <pushblind_repo>' first")
    end

    dtw.remove_any(repo .. "/dependencies")
    dtw.remove_any(repo .. "/release")
    os.execute("cd " .. repo .. " && darwin install darwindeps.json")
    os.execute("cd " .. repo .. " && darwin run_blueprint --target all")
    os.execute("cd " .. repo .. " && vibescript shipyard release.json")
    print("✅ Published VibeScript repo at: " .. repo)
end

