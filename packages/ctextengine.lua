relative_load('../utils/actions_factory.lua')
relative_load('../utils/utils.lua')

create_default_actions("ctextengine")

function PushBlind.actions.build()
  local repo = get_prop("ctextengine_repo")
  if not repo then
    error("You need to run: 'pushblind set_repo ctextengine <ctextengine_repo>' first")
  end

  os.execute("cd " .. repo .. " && darwin run_blueprint build/  --mode folder")
end