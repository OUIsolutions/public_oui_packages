relative_load('../utils/actions_factory.lua')
create_default_actions("luaShip", "OUIsolutions/LuaShip")

function PushBlind.actions.build()
  local repo = get_prop("luaShip_repo")
  if not repo then
    error("You need to run: 'pushblind set_repo luaShip <luaShip_repo>' first")
  end

  os.execute("cd " .. repo .. " && darwin run_blueprint")
end