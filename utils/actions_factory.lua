
function create_default_actions(project_name)

    function PushBlind.actions.set_repo()
    local repo_name = argv.get_next_unused()
    if not repo_name then
        error(project_name.." repo not found usage: pushblind set_repo "..project_name.." <"..project_name.."_repo>")
    end
    local path = dtw.get_absolute_path(repo_name)
    if not path then
        error("This repo does not exist")
    end
    set_prop(project_name.."_repo",path)
    end

    function PushBlind.actions.code()
        local repo = get_prop(project_name.."_repo")
        if not repo then
            error("You need to run: 'pushblind set_repo "..project_name.." <"..project_name.."_repo>' first")
        end
        os.execute("cd "..repo.." && git pull")
        os.execute("code "..repo)
    end

    function PushBlind.actions.mount()
        local repo = get_prop(project_name.."_repo")
        if not repo then
            error("You need to run: 'pushblind set_repo "..project_name.." <"..project_name.."_repo>' first")
        end
        local current_dir = dtw.get_absolute_path(".")
        local mount_dest = current_dir.."/"..project_name
        if not dtw.isdir(mount_dest) then
            os.execute("mkdir  -p "..mount_dest)
        end

        os.execute(" sudo mount --bind "..repo.." "..mount_dest)
    end
    function PushBlind.actions.umount()
        local current_dir = dtw.get_absolute_path(".")
        local mount_dest = current_dir.."/"..project_name
        if not dtw.isdir(mount_dest) then
            return print("This project is not mounted")
        end
        os.execute(" sudo umount "..mount_dest)
        os.execute(" rm -rf "..mount_dest)
    end
end   