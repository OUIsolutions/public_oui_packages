relative_load('../utils/actions_factory.lua')
create_default_actions("silverchain")

function PushBlind.actions.scratch_install()
  local repo = get_prop("silverchain_repo")
  if not repo then
    error("You need to run: 'pushblind set_repo silverchain <silverchain_repo>' first")
  end

  local mode = argv.get_flag_arg_by_index({ "mode" }, 1)
  if not mode then
    error("You need to specify the mode: 'pushblind scratch_install silverchain --mode <mode>'")
  end

  os.execute("cd " .. repo .. " && darwin run_blueprint build/ --mode folder " .. mode)
end