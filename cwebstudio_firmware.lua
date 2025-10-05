

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
    dtw.remove_any("CWebStudioFirmware.c")

end

function PushBlind.actions.remove()
    os.execute("sudo rm /usr/local/bin/CWebStudioFirmware")
end
