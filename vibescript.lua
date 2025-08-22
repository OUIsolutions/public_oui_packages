
function PushBlind.actions.install()

    dtw.remove_any("vibescript.out")
    local version = argv.get_flag_arg_by_index({ "version" },1)
    if  version then
        print("version"..version)
        os.execute('curl -L https://github.com/OUIsolutions/VibeScript/releases/download/' .. version .. '/vibescript.out -o vibescript.out')

    end 
    if not version then
        os.execute('curl -L https://github.com/OUIsolutions/VibeScript/releases/latest/download/vibescript.out -o vibescript.out') 
    end
    if not dtw.isfile("vibescript.out") then
        print("Error: vibescript.out not found")
        return false
    end

    os.execute("sudo chmod +x vibescript.out ")
    os.execute("sudo mv vibescript.out  /usr/local/bin/vibescript")

    return true
end

function PushBlind.actions.remove()
    os.execute("sudo rm /usr/local/bin/vibescript")
end
