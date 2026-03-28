relative_load('../utils/actions_factory.lua')
relative_load('../utils/utils.lua')

create_default_actions("BearHttpsClient")

function PushBlind.actions.build_deps()
    local bear_repo = get_prop("BearHttpsClient_repo")
    if not bear_repo then
        error("You need to run: 'pushblind set_repo BearHttpsClient <BearHttpsClient_repo>' first")
    end
    os.execute("cd " .. bear_repo .. " && darwin install darwindeps.json --soft")

    build_deps({
        project = "BearHttpsClient",
        dep = "BearSslSingleUnit",
        actions = {"build"},
        sources = {
            { target = "BearSSLSingleUnit.h", dest = "dependencies/BearSSLSingleUnit.h" },
            { target = "BearSSLSingleUnit.c", dest = "dependencies/BearSSLSingleUnit.c" }
        }
    })

    build_deps({
        project = "BearHttpsClient",
        dep = "cjson",
        actions = {},
        sources = {
        { target = "cJSON.c", dest = "dependencies/cJSON.c" },
        { target = "cJSON.h", dest = "dependencies/cJSON.h" }
        }
    })

    build_deps({
        project = "BearHttpsClient",
        dep = "c2wasm",
        actions = {"build"},
        sources = {
            { target = "c2wasm.c", dest = "dependencies/c2wasm.c" }
        }
    })

    build_deps({
        project = "BearHttpsClient",
        dep = "universalsocket",
        actions = {"build"},
        sources = {
            { target = "UniversalSocket.c", dest = "dependencies/UniversalSocket.c" },
            { target = "UniversalSocket.h", dest = "dependencies/UniversalSocket.h" }
        }
    })

    build_deps({
        project = "BearHttpsClient",
        dep = "BearSslTrustedAnchors",
        actions = {"build"},
        sources = {
            { target = "BearSslTrustAnchors.c", dest = "dependencies/BearSslTrustAnchors.c" },
        }
    })
    
end

function PushBlind.actions.build()
    local repo = get_prop("BearHttpsClient_repo")
    if not repo then
        error("You need to run: 'pushblind set_repo BearHttpsClient <BearHttpsClient_repo>' first")
    end
    os.execute("cd " .. repo .. " && darwin run_blueprint --target all")
end
