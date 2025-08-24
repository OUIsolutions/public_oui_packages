
function PushBlind.actions.install()

    dtw.remove_any("vibescript.out")
    local version = argv.get_flag_arg_by_index({ "version" },1)
    if  version then
        print("version"..version)
        os.execute('curl -L https://github.com/OUIsolutions/Darwin/releases/download/' .. version .. '/darwin_linux_bin.out -o darwin.out')

    end 
    if not version then
        os.execute('curl -L https://github.com/OUIsolutions/Darwin/releases/latest/download/darwin_linux_bin.out -o darwin.out') 
    end
    if not dtw.isfile("darwin.out") then
        print("Error: darwin.out not found")
        return false
    end

    os.execute("sudo chmod +x darwin.out ")
    os.execute("sudo mv darwin.out  /usr/local/bin/darwin")

    return true
end

function PushBlind.actions.remove()
    os.execute("sudo rm /usr/local/bin/darwin")
end
