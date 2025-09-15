
function PushBlind.actions.install()

    dtw.remove_any("darwin.out")
    local version = argv.get_flag_arg_by_index({ "version" },1)
    if  version then
        print("version"..version)
        os.execute('curl -L https://github.com/OUIsolutions/Darwin/releases/download/' .. version .. '/darwin.c -o darwin.c')

    end 
    if not version then
        os.execute('curl -L https://github.com/OUIsolutions/Darwin/releases/latest/download/darwin.c -o darwin.c') 
    end
    if not dtw.isfile("darwin.c") then
        print("Error: darwin.c not found")
        return false
    end
    os.execute("gcc  -o darwin.out darwin.c ")
    dtw.move_any_overwriting("darwin.out", "/usr/local/bin/darwin")
    dtw.remove_any("darwin.c")
    return true
end

function PushBlind.actions.remove()
    os.execute("sudo rm /usr/local/bin/darwin")
end
