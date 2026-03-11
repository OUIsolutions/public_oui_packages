
relative_load('../utils/actions_factory.lua')
create_default_actions("c2wasm")

function PushBlind.actions.build()
    local repo = get_prop("c2wasm_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo c2wasm <c2wasm_repo>' first")
    end
    os.execute("cd "..repo.." && darwin run_blueprint --target all")
end

function PushBlind.actions.build_deps()
    -- build_deps action is needed for the recursive build process of dependants to work,
    -- but since there are no dependencies, just call the build action directly
    PushBlind.actions.build()
end

function PushBlind.actions.publish()
    local repo = get_prop("c2wasm_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo c2wasm <c2wasm_repo>' first")
    end
    os.execute("cd "..repo.." && darwin run_blueprint --target all")
    os.execute("cd "..repo.." && vibescript shipyard  release.json")
    print("Published to repo "..repo)
end 
