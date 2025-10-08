function PushBlind.actions.set_repo()
   local repo_name = argv.get_next_unused()
   if not repo_name then
      error("darwin_repo not found usage: pushblind set_repo darwin <darwin_repo>")
   end
   local path = dtw.get_absolute_path(repo_name)
   if not path then
      error("This repo does not exist")
   end
   set_prop("darwin_repo",path)
end

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
    os.execute("cp "..repo.."/darwin.out /usr/local/bin/"..name)
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
        os.execute("mv darwin.out /usr/local/bin/darwin")
        os.execute("chmod +x /usr/local/bin/darwin")
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
        dtw.move_any_overwriting("darwin.out", "/usr/local/bin/darwin")
        dtw.remove_any("darwin.c")
    end 
end

function PushBlind.actions.remove()
    if os_name == "linux" then
        os.execute("rm /usr/local/bin/darwin")
    end
    if os_name == "mac" then
        os.execute("rm /usr/local/bin/darwin")
    end
end
