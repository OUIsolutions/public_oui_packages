
function PushBlind.actions.install()

    dtw.remove_any("vibescript.out")
    local version = argv.get_flag_arg_by_index({ "version" },1)
    if  version then
        print("version"..version)
        os.execute('curl -L https://github.com/OUIsolutions/VibeScript/releases/download/' .. version .. '/amalgamation.c -o amalgamation.c')

    end 
    if not version then
        os.execute('curl -L https://github.com/OUIsolutions/VibeScript/releases/latest/download/amalgamation.c -o amalgamation.c') 
    end
    if not dtw.isfile("amalgamation.c") then
        print("Error: amalgamation.c not found")
        return false
    end
    os.execute("gcc  -o vibescript.out amalgamation.c ")
    dtw.move_any_overwriting("vibescript.out", "/usr/local/bin/vibescript")
    dtw.remove_any("amalgamation.c")
    return true
end

function PushBlind.actions.remove()
    os.execute("sudo rm /usr/local/bin/vibescript")
end
