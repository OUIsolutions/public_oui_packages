
function create_default_actions(project_name, project_repository)

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

    if project_repository then
        local function table_contains(table, element)
            for _, value in pairs(table) do
                if value == element then
                    return true
                end
            end
            return false
        end

        function PushBlind.actions.clone()
            local package_owner, package_repo_name = project_repository:match("([^/]+)/([^/]+)")
            if not package_owner or not package_repo_name then
                error("Malformed repository format. Expected '<package_owner>/<repo>'.")
            end

            local url = "https://github.com/" .. project_repository .. ".git"
            print("Package owner: " .. package_owner)
            print("Package repository: " .. package_repo_name)
            print("Cloning from URL: " .. url .. "\n")

            local clone_command = "git clone " .. url

            local output_path = argv.get_flag_arg_by_index({ "output", "o" }, 1, package_repo_name)

            clone_command = clone_command .. " " .. output_path .. " 2> /dev/null"

            os.execute(clone_command)
            local absolute_repo_path = dtw.get_absolute_path(output_path)
            -- dtw returns nil if path doesnt exist
            if not absolute_repo_path then
                error("Failed to clone the package's repository.")
            end

            print("Repository cloned to: " .. absolute_repo_path)

            local should_set_repo = argv.flags_exist({ "set-repo", "s" })
            if should_set_repo then
                set_prop(project_name .. "_repo", absolute_repo_path)
                print("Repository prop path set")
            end
            
            print("Done")
        end
    end
end   