relative_load('../utils/actions_factory.lua')
relative_load('../utils/utils.lua')

create_default_actions("BearSslTrustedAnchors", "OUIsolutions/BearSSLTrustedAnchors")

function PushBlind.actions.build()
  local repo = get_prop("BearSslTrustedAnchors_repo")
  if not repo then
    error("You need to run: 'pushblind set_repo BearSslTrustedAnchors <BearSslTrustedAnchors_repo>' first")
  end

  os.execute("cd " .. repo .. " && chmod +x ./generator.sh && ./generator.sh")
end