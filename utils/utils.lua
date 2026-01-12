
function move_dep(src_repo,src_file, dest_repo,dest_file)
    
        local src_repo = get_prop(src_repo.."_repo")
    if not src_repo then
        error("You need to run: 'pushblind set_repo " .. src_repo .. " <" .. src_repo .. "_repo>' first")
    end
    local dest_repo = get_prop(dest_repo.."_repo")
    if not dest_repo then
        error("You need to run: 'pushblind set_repo " .. dest_repo .. " <" .. dest_repo .. "_repo>' first")
    end
    local src_path = src_repo .. "/" .. src_file
    
    if not dtw.isfile(src_path) then
        error("File not found: " .. src_path)
    end
    local dest_path = dest_repo .. "/" .. dest_file
    dtw.move_any_overwriting(src_path, dest_path)
end