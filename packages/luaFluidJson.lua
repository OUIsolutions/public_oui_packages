relative_load('../utils/actions_factory.lua')
create_default_actions("luaFluidJson")

function PushBlind.actions.build()
  local repo = get_prop("luaFluidJson_repo")
  if not repo then
    error("You need to run: 'pushblind set_repo luaFluidJson <luaFluidJson_repo>' first")
  end

  os.execute("cd " .. repo .. " && darwin run_blueprint build/ --mode folder build_local")
end