function PushBlind.actions.set_repo()
   local repo_name = argv.get_next_unused()
   if not repo_name then
      return print("You need to provide a repo name")
   end
   local path = dtw.get_absolute_path(repo_name)
   if not path then
      return print("This repo does not exist")
   end
   set_prop("cachify_repo",path)
end 
function PushBlind.actions.publish()
    local repo = get_prop("cachify_repo")
    if not repo then
        return print("You need to set a repo first")
    end
    os.execute("cd "..repo.." vibescript shipyard  release.json")
    print("Published to repo "..repo)

end 

function PushBlind.actions.install()
    if os_name == "linux" then 
        local version = argv.get_flag_arg_by_index({ "version" },1)
        if  version then
            print("version"..version)
            local ok, error = os.execute('vibescript add_script --file https://github.com/OUIsolutions/cachify/releases/download/' .. version .. '/cachify.lua cachify')
            if not ok then
                print("Error: " .. error)
                return false
            end
        end 
    
        if not version then
            local ok, error = os.execute('vibescript add_script --file https://github.com/OUIsolutions/cachify/releases/latest/download/cachify.lua cachify') 
            
            if not ok then
                print("Error: " .. error)
                return false
            end
        end

        print("cachify instalado com suscesso")
    end 

    if os_name == "mac" then 
        local version = argv.get_flag_arg_by_index({ "version" },1)
        if  version then
            print("version"..version)
            os.execute('vibescript add_script --file https://github.com/OUIsolutions/cachify/releases/download/' .. version .. '/cachify.lua cachify')

        end 
        if not version then
            os.execute('vibescript add_script --file https://github.com/OUIsolutions/cachify/releases/latest/download/cachify.lua cachify') 
        end
        print("cachify instalado com suscesso")
    end 
end

function PushBlind.actions.remove()
    if os_name == "linux" then
        os.execute("vibescript remove_script cachify")
    end
    if os_name == "mac" then
        os.execute("vibescript remove_script cachify")
    end
end
