relative_load('../utils/actions_factory.lua')
create_default_actions("luaCAmalgamator")

function PushBlind.actions.build()
  local repo = get_prop("luaCAmalgamator_repo")
  if not repo then
    error("You need to run: 'pushblind set_repo luaCAmalgamator <luaCAmalgamator_repo>' first")
  end

  os.execute("cd " .. repo .. " && darwin run_blueprint build/ --mode folder")
end