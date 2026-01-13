relative_load('../utils/actions_factory.lua')
relative_load('../utils/utils.lua')

create_default_actions("vibescript")

function PushBlind.actions.repo_install()
    local repo = get_prop("vibescript_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo vibescript <vibescript_repo>' first")
    end

    os.execute("cd " .. repo .. " && darwin run_blueprint --target amalgamation")
    os.execute("cd " .. repo .. " && gcc -o vibescript.out release/amalgamation.c")
    os.execute("chmod +x " .. repo .. "/vibescript.out")

    local name = argv.get_next_unused()
    if not name then
        name = "vibescript"
    end
    os.execute("sudo cp " .. repo .. "/vibescript.out /usr/local/bin/" .. name)
end
function PushBlind.actions.build_deps()
    local repo = get_prop("vibescript_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo vibescript <vibescript_repo>' first")
    end

    os.execute("cd " .. repo .. " && darwin install darwindeps.json --soft")

    PushBlind.run_action("doTheWorld","build")
    move_dep("doTheWorld", "release/doTheWorldOne.c", "vibescript", "dependencies/doTheWorldOne.c")
    move_dep("doTheWorld", "release/doTheWorld.h", "vibescript", "dependencies/doTheWorld.h")

    PushBlind.run_action("luaargv","build")
    move_dep("luaargv", "luargv.lua", "vibescript", "luargv.lua")

     
end

function PushBlind.actions.amalgamate()
    local repo = get_prop("vibescript_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo vibescript <vibescript_repo>' first")
    end

    os.execute("cd " .. repo .. " && darwin run_blueprint --target amalgamation")
end

function PushBlind.actions.publish()
    local repo = get_prop("vibescript_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo vibescript <vibescript_repo>' first")
    end

    dtw.remove_any(repo .. "/dependencies")
    dtw.remove_any(repo .. "/release")

    os.execute("cd " .. repo .. " && darwin install darwindeps.json")
    os.execute("cd " .. repo .. " && darwin run_blueprint --target all")

    os.execute("cd " .. repo .. " && vibescript shipyard release.json")

    print("✅ Published VibeScript repo at: " .. repo)
end



function PushBlind.actions.install()
    if os_name == "linux" then 
               dtw.remove_any("vibescript.out")
        local version = argv.get_flag_arg_by_index({ "version" },1)
        if  version then
            print("version"..version)
            os.execute('curl -L https://github.com/OUIsolutions/VibeScript/releases/download/' .. version .. '/vibescript.out -o vibescript.out')

        end 
        if not version then
            os.execute('curl -L https://github.com/OUIsolutions/VibeScript/releases/latest/download/vibescript.out -o vibescript.out') 
        end

        if not dtw.isfile("vibescript.out") then
            print("Error: vibescript.out not found")
            return false
        end
        os.execute("sudo mv vibescript.out /bin/vibescript")
        os.execute("sudo chmod +x /bin/vibescript")
        print("vibescript instalado com suscesso")
    end 

    if os_name == "mac" then 
        dtw.remove_any("vibescript.out")
        local version = argv.get_flag_arg_by_index({ "version" },1)
        if  version then
            print("version"..version)
            os.execute('curl -L https://github.com/OUIsolutions/VibeScript/releases/download/' .. version .. '/amalgamation.c -o amalgamation.c')

        end 
        if not version then
            os.execute('curl -L https://github.com/OUIsolutions/VibeScript/releases/latest/download/amalgamation.c -o amalgamation.c') 
        end
        if not dtw.isfile("amalgamation.c") then
            print("Error: amalgamation.c not found")
            return false
        end
        os.execute("gcc  -o vibescript.out amalgamation.c ")
        dtw.move_any_overwriting("vibescript.out", "/usr/local/bin/vibescript")
        dtw.remove_any("amalgamation.c")
    end 
end





function PushBlind.actions.amalgamate()

    local repo = get_prop("vibescript_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo vibescript <vibescript_repo>' first")
    end

    os.execute("cd " .. repo .. " && darwin run_blueprint --target amalgamation")
end






function PushBlind.actions.remove()
    os.execute("sudo rm /usr/local/bin/vibescript")
end
