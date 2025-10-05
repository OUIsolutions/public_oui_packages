function PushBlind.actions.set_repo()
   local repo_name = argv.get_next_unused()
   if not repo_name then
      return print("You need to provide a repo dir")
   end
   local path = dtw.get_absolute_path(repo_name)
   if not path then
      return print("This repo does not exist")
   end
   set_prop("cwebstudio_firmware_repo",path)
end

function PushBlind.actions.publish()
    local repo = get_prop("cwebstudio_firmware_repo")
    if not repo then
        return print("You need to run: 'pushblind set_repo cwebstudio_firmware <cwebstudio_firmware_repo>' first")
    end

    
    os.execute("cd "..repo.." && vibescript shipyard  release.json")
    print("Published to repo "..repo)

end

function PushBlind.actions.install()

    dtw.remove_any("firwmare.out")
    local version = argv.get_flag_arg_by_index({ "version" },1)
    if  version then
        print("version"..version)
        os.execute('curl -L https://github.com/OUIsolutions/CWebStudioFirmware/releases/download/' .. version .. '/amalgamation.c -o CWebStudioFirmware.c')

    end 
    if not version then
        os.execute('curl -L https://github.com/OUIsolutions/CWebStudioFirmware/releases/latest/download/CWebStudioFirmware.c -o CWebStudioFirmware.c') 
    end
    if not dtw.isfile("CWebStudioFirmware.c") then
        print("Error: CWebStudioFirmware.c not found")
        return false
    end
    os.execute("gcc  -o CWebStudioFirmware.out CWebStudioFirmware.c ")
    dtw.move_any_overwriting("CWebStudioFirmware.out", "/usr/local/bin/CWebStudioFirmware")
    os.execute("chmod +x /usr/local/bin/CWebStudioFirmware")
    dtw.remove_any("CWebStudioFirmware.c")

end

function PushBlind.actions.remove()
    os.execute("sudo rm /usr/local/bin/CWebStudioFirmware")
end
