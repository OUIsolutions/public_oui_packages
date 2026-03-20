relative_load('../utils/actions_factory.lua')
relative_load('../utils/utils.lua')
create_default_actions("luaSilverChain")

function PushBlind.actions.build_deps()
  local repo = get_prop("luaSilverChain_repo")
  if not repo then
      error("You need to run: 'pushblind set_repo luaSilverChain <luaSilverChain_repo>' first")
  end

  build_deps({
    project = "luaSilverChain",
    dep = "luacembed",
    actions = {"build_deps", "build"},
    sources = {
        { target = "release/LuaCEmbedOne.c", dest = "dependencies/LuaCEmbedOne.c" }
    }
  })

  build_deps({
    project = "luaSilverChain",
    dep = "silverchain",
    actions = {"amalgamate"},
    sources = {
        { target = "release/SilverChainApiNoDependenciesIncluded.h ", dest = "dependencies/SilverChainApiNoDependenciesIncluded.h" }
    }
  })

  build_deps({
    project = "luaSilverChain",
    dep = "ctextengine",
    actions = {"build"},
    sources = {
        { target = "release/CTextEngine.h", dest = "dependencies/CTextEngine.h" }
    }
  })

  build_deps({
    project = "luaSilverChain",
    dep = "doTheWorld",
    actions = {"build_deps", "build"},
    sources = {
        { target = "release/doTheWorld.h", dest = "dependencies/doTheWorld.h" }
    }
  })

  build_deps({
    project = "luaSilverChain",
    dep = "c-cli-entry",
    actions = {},
    sources = {
        { target = "CliEntry.h", dest = "dependencies/CliEntry.h" }
    }
  })
end

function PushBlind.actions.build()
    local repo = get_prop("luaSilverChain_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo luaSilverChain <luaSilverChain_repo>' first")
    end

    os.execute("cd "..repo.." && darwin run_blueprint build/ --mode folder)
end