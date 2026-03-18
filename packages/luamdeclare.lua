relative_load('../utils/actions_factory.lua')
create_default_actions("luamdeclare")

function PushBlind.actions.build()
  local repo = get_prop("luamdeclare_repo")
  if not repo then
    error("You need to run: 'pushblind set_repo luamdeclare <luamdeclare_repo>' first")
  end

  os.execute("cd " .. repo .. " && darwin run_blueprint darwinconf.lua build_local")
end