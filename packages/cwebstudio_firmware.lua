
relative_load('../utils/actions_factory.lua')
create_default_actions("cwebstudio_firmware")


function PushBlind.actions.dep_install()
    local repo = get_prop("cwebstudio_firmware_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo cwebstudio_firmware <cwebstudio_firmware_repo>' first")
    end
    os.execute("cd "..repo.." && darwin install")
end

function PushBlind.actions.build()
    local repo = get_prop("cwebstudio_firmware_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo cwebstudio_firmware <cwebstudio_firmware_repo>' first")
    end
    dtw.remove_any(repo.."/release")
    os.execute("cd "..repo.." && darwin install darwindeps.json --soft")
    os.execute("cd "..repo.." && darwin run_blueprint build/ --mode folder amalgamation_build zip_build")
end


function PushBlind.actions.repo_install()
    local repo = get_prop("cwebstudio_firmware_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo cwebstudio_firmware <cwebstudio_firmware_repo>' first")
    end
    os.execute("cd "..repo.." && darwin install darwindeps.json --soft")
    os.execute("cd "..repo.." && darwin run_blueprint build/ --mode folder local_build ")
    os.execute("chmod +x "..repo.."/CWebStudioFirmware")
    os.execute("sudo cp "..repo.."/CWebStudioFirmware /usr/local/bin/CWebStudioFirmware")
end


function PushBlind.actions.publish()
    local repo = get_prop("cwebstudio_firmware_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo cwebstudio_firmware <cwebstudio_firmware_repo>' first")
    end

    dtw.remove_any(repo.."/dependencies")
    dtw.remove_any(repo.."/release")
    os.execute("cd "..repo.." && darwin install darwindeps.json ")
    os.execute("cd "..repo.." && darwin run_blueprint darwinconf.lua --target all ")

    os.execute("cd "..repo.." && vibescript shipyard  release.json")
    print("Published to repo "..repo)

end

function PushBlind.actions.install()

    dtw.remove_any("firwmare.out")
    local version = argv.get_flag_arg_by_index({ "version" },1)
    if  version then
        print("version"..version)
        os.execute('curl -L https://github.com/OUIsolutions/CWebStudioFirmware/releases/download/' .. version .. '/CWebStudioFirmware.c -o CWebStudioFirmware.c')

    end 
    if not version then
        os.execute('curl -L https://github.com/OUIsolutions/CWebStudioFirmware/releases/latest/download/CWebStudioFirmware.c -o CWebStudioFirmware.c') 
    end
    if not dtw.isfile("CWebStudioFirmware.c") then
        print("Error: CWebStudioFirmware.c not found")
        return false
    end
    os.execute("gcc  -o CWebStudioFirmware.out CWebStudioFirmware.c ")
    os.execute("sudo mv CWebStudioFirmware.out /usr/local/bin/CWebStudioFirmware")
    os.execute("sudo chmod +x /bin/CWebStudioFirmware")
    dtw.remove_any("CWebStudioFirmware.c")

end

function PushBlind.actions.remove()
    print("inicou o pacote")
    os.execute("sudo rm /usr/local/bin/CWebStudioFirmware")
end
