relative_load('../utils/actions_factory.lua')
create_default_actions("universalsocket", "samuelHenriqueDeMoraisVitrio/universalsocket")
  

function PushBlind.actions.build()
    local repo = get_prop("universalsocket_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo universalsocket <universalsocket_repo>' first")
    end
    
    os.execute("cd " .. repo .. " && darwin run_blueprint -mode folder build")
end