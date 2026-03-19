relative_load('../utils/actions_factory.lua')
create_default_actions("silverchain")

function table_contains(tbl, val)
    for _, v in ipairs(tbl) do
      if v == val then
        return true
      end
    end
    return false
  end

function build_package(mode, repo)
  local available_build_modes = {}
  local available_build_modes_raw = dtw.list_files(repo .. "/build/build")
  for _, file in ipairs(available_build_modes_raw) do
    table.insert(available_build_modes, file:match("(.*)_build.lua"))
  end

  if not table_contains(available_build_modes, mode) then
    error("Invalid mode: " .. mode .. ". Available modes are: " .. table.concat(available_build_modes, ", "))
  end
  mode = mode .. "_build"

  os.execute("cd " .. repo .. " && darwin run_blueprint build/ --mode folder " .. mode)
end

function PushBlind.actions.scratch_install()
  local repo = get_prop("silverchain_repo")
  if not repo then
    error("You need to run: 'pushblind set_repo silverchain <silverchain_repo>' first")
  end

  build_package("amalgamation", repo)

  local release_file = "SilverChain .c"
  os.execute("cd " .. repo .. "/release && gcc -o silverChain")
  os.execute("mv " .. repo .. "/release/silverChain ~/.local/bin/silverChain")
end

function PushBlind.actions.build()
  local repo = get_prop("silverchain_repo")
  if not repo then
    error("You need to run: 'pushblind set_repo silverchain <silverchain_repo>' first")
  end

  local mode = argv.get_flag_arg_by_index({ "mode" }, 1)
  if not mode then
    error("You need to specify the mode: 'pushblind scratch_install silverchain --mode <mode>'")
  end
  
  build_package(mode, repo)
end