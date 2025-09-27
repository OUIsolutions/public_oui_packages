
function PushBlind.actions.install()
    if os_name == "linux" then 
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
        os.execute("sudo mv vibescript.out /bin/vibescript")
    end 

    if os_name == "mac" then 
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
    end 
end

function PushBlind.actions.remove()
    os.execute("sudo rm /usr/local/bin/vibescript")
end
