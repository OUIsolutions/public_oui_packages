


relative_load('../utils/actions_factory.lua')
create_default_actions("darwin")

function PushBlind.actions.repo_install()
    local repo = get_prop("darwin_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo darwin <darwin_repo>' first")
    end
--    os.execute("cd "..repo.." && darwin install darwindeps.json --soft")
    os.execute("cd "..repo.." && darwin run_blueprint --target amalgamation")
    os.execute("cd "..repo.. "&& gcc -o darwin.out release/darwin.c")
    os.execute("chmod +x "..repo.."/darwin.out")

    local name = argv.get_next_unused()
    if not name then
        name = "darwin"
    end
    
    if os_name == "mac" then 
        os.execute("sudo cp "..repo.."/darwin.out /usr/local/bin/"..name)
    else
        os.execute("sudo cp "..repo.."/darwin.out /usr/bin/"..name)
    end
    dtw.remove_any("darwin.out")
end

function PushBlind.actions.build_deps()
    local repo = get_prop("darwin_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo darwin <darwin_repo>' first")
    end

    build_deps({
        project = "darwin",
        dep = "mdeclare",
        actions = {"build"},
        sources = {
            { target = "release/MDeclareApiNoDependenciesIncluded.h", dest = "dependencies/MDeclareApiNoDependenciesIncluded.h" },
        }
    })

    build_deps({
        project = "darwin",
        dep = "luaFluidJson",
        actions = {"build"},
        sources = {
            { target = "release/luaFluidJson_no_dep.c", dest = "dependencies/luaFluidJson_no_dep.c" },
        }
    })

    build_deps({
        project = "darwin",
        dep = "luaDoTheWorld",
        actions = {"build_deps", "build"},
        sources = {
            { target = "release/luaDoTheWorld_no_dep.c", dest = "dependencies/luaDoTheWorld_no_dep.c" },
        }
    })

    os.execute("cd "..repo.." && curl -L https://github.com/SamuelHenriqueDeMoraisVitrio/candangoEngine/releases/download/0.2.2/CandangoEngine.c -o dependencies/CandangoEngine.c")

    build_deps({
        project = "darwin",
        dep = "ctextengine",
        actions = {"build"},
        sources = {
            { target = "release/CTextEngineOne.c", dest = "dependencies/CTextEngineOne.c" },
        }
    })

    build_deps({
        project = "darwin",
        dep = "luamdeclare",
        actions = {"build"},
        sources = {
            { target = "release/luamdeclare.c", dest = "dependencies/luamdeclare.c" },
        }
    })

    build_deps({
        project = "darwin",
        dep = "luaargv",
        actions = {"build"},
        sources = {
            { target = "release/luargv.c", dest = "dependencies/luargv.c" },
        }
    })

    build_deps({
        project = "darwin",
        dep = "luaShip",
        actions = {"build"},
        sources = {
            { target = "release/LuaShip.c", dest = "dependencies/LuaShip.c" },
        }
    })

    build_deps({
        project = "darwin",
        dep = "luaSilverChain",
        actions = {"build"},
        sources = {
            { target = "release/silverchain_no_dependecie_included.c", dest = "dependencies/silverchain_no_dependecie_included.c" },
        }
    })

    build_deps({
        project = "darwin",
        dep = "luaCAmalgamator",
        actions = {"build"},
        sources = {
            { target = "release/lua_c_amalgamator_dependencie_not_included.c", dest = "dependencies/lua_c_amalgamator_dependencie_not_included.c" },
        }
    })
end

function PushBlind.actions.scratch_install()
    PushBlind.run_action("darwin", "build_deps")
    PushBlind.run_action("darwin", "build")

    local repo = get_prop("darwin_repo")
end

function PushBlind.actions.build()
   local repo = get_prop("darwin_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo darwin <darwin_repo>' first")
    end

    os.execute("cd "..repo.." && darwin install darwindeps.json --soft")
    os.execute("cd "..repo.." && darwin run_blueprint --target all")
end

function PushBlind.actions.publish()
   local repo = get_prop("darwin_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo darwin <darwin_repo>' first")
    end

    dtw.remove_any(repo.."/dependencies")
    dtw.remove_any(repo.."/release")

    os.execute("cd "..repo.." && darwin install darwindeps.json ")
    os.execute("cd "..repo.." && darwin run_blueprint --target all")
    os.execute("cd "..repo.." && vibescript shipyard  release.json")
    print("Published to repo "..repo)

end

function PushBlind.actions.install()
    if os_name == "linux" then 
        dtw.remove_any("darwin.out")
        local version = argv.get_flag_arg_by_index({ "version" },1)
        if  version then
            print("version"..version)
            os.execute('curl -L https://github.com/OUIsolutions/Darwin/releases/download/' .. version .. '/darwin_linux_bin.out -o darwin.out')

        end 
        if not version then
            os.execute('curl -L https://github.com/OUIsolutions/Darwin/releases/latest/download/darwin_linux_bin.out -o darwin.out') 
        end

        if not dtw.isfile("darwin.out") then
            print("Error: darwin.out not found")
            return false
        end
        os.execute("sudo mv darwin.out /usr/bin/darwin")
        os.execute("sudo chmod +x /usr/bin/darwin")
        print("darwin instalado com suscesso")
    end 

    if os_name == "mac" then 
        dtw.remove_any("darwin.out")
        local version = argv.get_flag_arg_by_index({ "version" },1)
        if  version then
            print("version"..version)
            os.execute('curl -L https://github.com/OUIsolutions/Darwin/releases/download/' .. version .. '/darwin.c -o darwin.c')

        end 
        if not version then
            os.execute('curl -L https://github.com/OUIsolutions/Darwin/releases/latest/download/darwin.c -o darwin.c') 
        end
        if not dtw.isfile("darwin.c") then
            print("Error: darwin.c not found")
            return false
        end
        os.execute("gcc  -o darwin.out darwin.c ")
        os.execute("mv darwin.out /usr/local/bin/darwin")
        os.execute("chmod +x /usr/local/bin/darwin")
        dtw.remove_any("darwin.c")
    end 
end

function PushBlind.actions.remove()
    if os_name == "linux" then
        os.execute("rm /usr/bin/darwin")
    end
    if os_name == "mac" then
        os.execute("rm /usr/bin/darwin")
    end
end
