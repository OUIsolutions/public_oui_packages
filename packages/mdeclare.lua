relative_load('../utils/actions_factory.lua')
create_default_actions("mdeclare")

function PushBlind.actions.build()
  local repo = get_prop("mdeclare_repo")
  if not repo then
    error("You need to run: 'pushblind set_repo mdeclare <mdeclare_repo>' first")
  end

  os.execute("cd " .. repo .. " && darwin run_blueprint build/ --mode folder amalgamation_build")
end

function PushBlind.actions.install()
  PushBlind.run_action("mdeclare", "build")
  if not repo then
    error("You need to run: 'pushblind set_repo mdeclare <mdeclare_repo>' first")
  end

  os.execute("cd " .. repo .. "/release && gcc MDeclare.c -o mdeclare")
  os.execute("mv " .. repo .. "/release/mdeclare ~/.local/bin/mdeclare")
  print("MDeclare installed successfully as 'mdeclare' command.")
end