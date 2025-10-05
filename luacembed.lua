function PushBlind.actions.set_repo()
   local repo_name = argv.get_next_unused()
   if not repo_name then
      error("luacembed_repo not found usage: pushblind set_repo luacembed <luacembed_repo>")
   end
   local path = dtw.get_absolute_path(repo_name)
   if not path then
      error("This repo does not exist")
   end
   set_prop("luacembed_repo",path)
end

function PushBlind.actions.publish()
   local repo = get_prop("luacembed_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo luacembed <luacembed_repo>' first")
    end

    dtw.remove_any(repo.."/dependencies")
    dtw.remove_any(repo.."/release")

    os.execute("cd "..repo.." && darwin install darwindeps.json ")
    os.execute("cd "..repo.." && darwin run_blueprint --target all")
    os.execute("cd "..repo.." && vibescript shipyard  release.json")
    print("Published to repo "..repo)

end


