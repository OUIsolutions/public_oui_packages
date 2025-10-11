relative_load('utils/actions_factory.lua')
create_default_actions("public_oui")


function PushBlind.actions.update(running_dir)

    local packages = dtw.list_files_recursively(running_dir.."/packages",false)
    for i=1,#packages do 
        local file = packages[i]
        
        local path = dtw.newPath(file)
        local name = path.get_only_name()
    
        PushBlind.add_package({
            repo = PushBlind.same,
            filename = "packages/"..file,
            name = name,
            force=false
        })

    end 
    


    return true
end
