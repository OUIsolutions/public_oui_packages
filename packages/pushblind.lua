relative_load('../utils/actions_factory.lua')
relative_load('../utils/utils.lua')
create_default_actions("pushblind", "OUIsolutions/PushBlind")
function PushBlind.actions.scratch_install()
    PushBlind.run_action("vibescript","build_deps") 
    local repo = get_prop("vibescript_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo vibescript <vibescript_repo>' first")
    end

    os.execute("cd " .. repo .. " && darwin run_blueprint --target amalgamation")

    
end
function PushBlind.actions.repo_install()
    local repo = get_prop("pushblind_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo pushblind <pushblind_repo>' first")
    end

    os.execute("cd " .. repo .. " && darwin install --soft")
    os.execute("cd " .. repo .. " && darwin run_blueprint --target all")
    
    if os_name == "linux" then
        os.execute("sudo dpkg -i " .. repo .. "/release/pushblind.deb")
    end
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

