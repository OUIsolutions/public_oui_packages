function PushBlind.actions.set_repo()
   local repo_name = argv.get_next_unused()
   if not repo_name then
      error("public_oui repo not found usage: pushblind set_repo public_oui <cachify_repo>")
   end
   local path = dtw.get_absolute_path(repo_name)
   if not path then
      error("This repo does not exist")
   end
   set_prop("public_oui_repo",path)
end


function PushBlind.actions.code()
    local repo = get_prop("public_oui_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo public_oui <public_oui_repo>' first")
    end
    os.execute("cd "..repo.." && git pull")
    os.execute("code "..repo)
end

function PushBlind.actions.update()

    local packages = dtw.list_files_recursively("packages",true)
    for i=1,#packages do 
        local file = packages[i]
        local path = dtw.newPlath(file)
        local filename = path.get_only_name()
        print("Updating package: "..filename)
    end 
    
    --PushBlind.add_package({
    --    repo = PushBlind.same,
    --   filename = "vibescript.lua",
    --    name = "vibescript",
    --   force=false
    --})

    return true
end
