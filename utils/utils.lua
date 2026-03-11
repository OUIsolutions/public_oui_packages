
function build_deps(props)
    print("\n\nBuilding dependencies for " .. props.project .. " from " .. props.dep)

    local project_repo = get_prop(props.project.."_repo")
    if not project_repo then
        error("You need to run: 'pushblind set_repo " .. props.project .. " <" .. props.project .. "_repo>' first")
    end
    local dep_repo = get_prop(props.dep.."_repo")
    if not dep_repo then
        error("You need to run: 'pushblind set_repo " .. props.dep .. " <" .. props.dep .. "_repo>' first")
    end

    for _, action in ipairs(props.actions) do
        print("Running action '" .. action .. "' for dependency '" .. props.dep .. "'")
        local ok,err = PushBlind.run_action(props.dep, action)
        if not ok then
            error(err)
        end
    end

    print("\nCopying sources for dependency '" .. props.dep .. "'")
    for _, source in ipairs(props.sources) do
        local src_path = dep_repo .. "/" .. source.target
        print("\Checking if source file exists: " .. src_path)
        if not dtw.isfile(src_path) then
            error("File not found: " .. src_path)
        end
        local dest_path = project_repo .. "/" .. source.dest
        dtw.copy_any_overwriting(src_path, dest_path)
        print("Copied '" .. src_path .. "' to '" .. dest_path .. "'")
    end

end