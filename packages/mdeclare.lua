relative_load('../utils/actions_factory.lua')
create_default_actions("mdeclare")

function PushBlind.actions.build()
  local repo = get_prop("mdeclare_repo")
  if not repo then
    error("You need to run: 'pushblind set_repo mdeclare <mdeclare_repo>' first")
  end

  os.execute("cd " .. repo .. " && darwin run_blueprint build/ --mode folder amalgamation_build")
end