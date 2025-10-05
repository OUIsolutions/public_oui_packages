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
   -- os.execute("chmod +x "..repo.."/CWebStudioFirmware")
   -- os.execute("sudo cp "..repo.."/CWebStudioFirmware /usr/local/bin/CWebStudioFirmware")
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
        os.execute("sudo mv darwin.out /bin/darwin")
        os.execute("sudo chmod +x /bin/darwin")
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
        os.execute("sudo rm /bin/darwin")
    end
    if os_name == "mac" then
        os.execute("sudo rm /usr/local/bin/darwin")
    end
end
