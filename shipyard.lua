
function PushBlind.actions.install()
    if os_name == "linux" then 
        local version = argv.get_flag_arg_by_index({ "version" },1)
        if  version then
            print("version"..version)
            local ok, error = os.execute('vibescript add_script --file https://github.com/OUIsolutions/shipyard/releases/download/' .. version .. '/shipyard.lua shipyard')
            if not ok then
                print("Error: " .. error)
                return false
            end
        end 
    
        if not version then
            local ok, error = os.execute('vibescript add_script --file https://github.com/OUIsolutions/shipyard/releases/latest/download/shipyard.lua shipyard')
            
            if not ok then
                print("Error: " .. error)
                return false
            end
        end

        print("shipyard instalado com suscesso")
    end 

    if os_name == "mac" then 
        local version = argv.get_flag_arg_by_index({ "version" },1)
        if  version then
            print("version"..version)
            os.execute('vibescript add_script --file https://github.com/OUIsolutions/shipyard/releases/download/' .. version .. '/shipyard.lua shipyard')

        end 
        if not version then
            os.execute('vibescript add_script --file https://github.com/OUIsolutions/shipyard/releases/latest/download/shipyard.lua shipyard')
        end
        print("shipyard instalado com suscesso")
    end 
end

function PushBlind.actions.remove()
    if os_name == "linux" then
        os.execute("vibescript remove_script shipyard")
    end
    if os_name == "mac" then
        os.execute("vibescript remove_script shipyard")
    end
end
